import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch user details
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Logout method
  Future<void> logout() async {
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    User? user = getCurrentUser(); // Get the current user

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Logout icon
            onPressed: () async {
              await logout(); // Call logout function
              Navigator.of(context).pushReplacementNamed('/login'); // Redirect to login page
            },
          ),
        ],
      ),
      body: user != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50, // Profile picture size
                    backgroundImage: NetworkImage(user.photoURL ?? ''), // Profile picture URL
                  ),
                  SizedBox(height: 16),
                  Text(
                    user.displayName ?? 'No Name', // Display user name
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Text(
                    user.email ?? 'No Email', // Display user email
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Additional Info',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  // Add any additional user information here
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()), // Loading indicator if user is null
    );
  }
}
