import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:test/admin/admin_page.dart";
import "package:test/pages/home_page.dart";
import "package:test/services/auth/login_or_register.dart";

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<String?> getUserRole(String uid) async {
    try {
      DocumentSnapshot doc =
      await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        return doc['role'];
      }
    } catch (e) {
      print('Error fetching user role: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            User? user = snapshot.data;
            return FutureBuilder<String?>(
              future: getUserRole(user!.uid),
              builder: (context, AsyncSnapshot<String?> roleSnapshot) {
                if (roleSnapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (roleSnapshot.hasData) {
                  if (roleSnapshot.data == 'admin') {
                    return const AdminPage();
                  } else {
                    return const HomePage();
                  }
                } else {
                  return const LoginOrRegister();
                }
              },
            );
          } else {
            return const LoginOrRegister();
          }
        },
      ),
    );
  }
}
