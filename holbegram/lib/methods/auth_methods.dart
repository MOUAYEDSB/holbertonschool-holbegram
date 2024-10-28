// lib/methods/auth_methods.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:typed_data';
import '../models/user.dart'; // Import your Users model

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sign Up Method
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    String bio = "",
    String photoUrl = "",
    Uint8List? file,
  }) async {
    String res = "An error occurred";

    try {
      // Check if fields are empty
      if (email.isEmpty || password.isEmpty || username.isEmpty) {
        return "Please fill all the fields";
      }

      // Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the user from the userCredential
      User user = userCredential.user!;

      // Create a new user instance using the Users model
      Users newUser = Users(
        uid: user.uid,
        email: email,
        username: username,
        bio: bio,
        photoUrl: photoUrl,
        followers: [],
        following: [],
        posts: [],
        saved: [],
        searchKey: username[0].toUpperCase(),
      );

      // Save user data to Firestore
      await _firestore.collection("users").doc(user.uid).set(newUser.toJson());

      // Return success
      res = "success";
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  // Method to get user details by user ID
  Future<Users?> getUserDetails(String userId) async {
    try {
      DocumentSnapshot snapshot = await _firestore.collection("users").doc(userId).get();
      if (snapshot.exists) {
        return Users.fromSnap(snapshot); // Use your fromSnap method
      }
    } catch (e) {
      throw Exception("Error fetching user details: $e");
    }
    return null; // Return null if user is not found
  }
}
