import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  //get instance of firebase auth
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  //get current user
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  //sign in
  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      //sign user in
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      return userCredential;
    }

    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign up
  Future<UserCredential> signUpWithEmailPassword(String email, password) async {
    try {
      //sign user in
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      // Get the user
      User? user = userCredential.user;

      if (user != null) {
        // Create a document in the "users" collection
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email,
          'role': 'user', // You can set a default role or customize as needed
          'uid': user.uid,
          'username': "",
        });
      }

      return userCredential;
    }

    //catch any errors
    on FirebaseAuthException catch (e) {
      throw Exception(e.code);
    }
  }

  //sign out
  Future<void> signOut() async {
    return await _firebaseAuth.signOut();
  }
}
