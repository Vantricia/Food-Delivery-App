import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? userEmail;
  String? username;
  bool isUpdating = false;
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      userEmail = user.email;
      var snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      username = snapshot.data()?['username'];
    } else {
      userEmail = 'Your Email';
      username = 'Your Username';
    }
    setState(() {});
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
        username = newName; // Update local cache
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

  void logout() {
    final authService = AuthService();
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 40),
            const Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: AssetImage(
                    "lib/images/profile/profile.jpeg"), // replace with your image asset
              ),
            ),
            const SizedBox(height: 40),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                iconColor: Theme.of(context).colorScheme.inversePrimary,
                leading: const Icon(Icons.mail),
                title: Text(
                  userEmail ?? 'Your Email',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                onTap: () {
                  // Navigate to edit profile screen
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                iconColor: Theme.of(context).colorScheme.inversePrimary,
                leading: const Icon(Icons.person),
                title: Text(
                  username ?? 'Your Username',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                onTap: () {
                  openUsernameDialog(context, username ?? 'Your Username');
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                iconColor: Theme.of(context).colorScheme.inversePrimary,
                leading: const Icon(Icons.notifications),
                title: Text('Notifications',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
                onTap: () {
                  // Navigate to notifications screen
                },
              ),
            ),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListTile(
                iconColor: Theme.of(context).colorScheme.inversePrimary,
                leading: const Icon(Icons.logout),
                title: Text('Log Out',
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary)),
                onTap: logout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
