import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyUsername extends StatefulWidget {
  @override
  _MyUsernameState createState() => _MyUsernameState();
}

class _MyUsernameState extends State<MyUsername> {
  final textController = TextEditingController();
  String? currentUsername;
  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    getUsername();
  }

  void updateUsername(BuildContext context, String? uid, String newName) async {
    if (uid == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user logged in")),
      );
      return;
    }
    setState(() {
      isUpdating = true; // Show loading indicator
    });
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).update({
        'username': newName,
      });
      setState(() {
        currentUsername = newName; // Update local cache
        isUpdating = false; // Hide loading indicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username updated successfully!")),
      );
    } catch (error) {
      setState(() {
        isUpdating = false; // Hide loading indicator
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to update username: $error")),
      );
    }
  }

  void openUsernameDialog(BuildContext context, String initialName) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No user logged in")),
      );
      return;
    }
    textController.text = initialName; // Pre-fill with the current username
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Your Username"),
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
              hintText: "Enter your new username",
              border: OutlineInputBorder(), // Adds outline border
              labelText: 'Username' // Labels the text field
              ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Cancel"),
          ),
          MaterialButton(
            onPressed: () {
              String newName = textController.text;
              updateUsername(context, user.uid, newName);
              Navigator.pop(context);
              textController.clear();
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> getUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      setState(() {
        currentUsername = 'Username'; // Default if no user is logged in
      });
      return;
    }
    var snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();
    setState(() {
      currentUsername = snapshot.data()?['username'] ?? 'Username';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              openUsernameDialog(context, currentUsername ?? "Username");
            },
            child: Row(
              children: [
                Text(
                  currentUsername ?? "Username",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                Icon(Icons.edit,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
