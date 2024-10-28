import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/methods/user_storage.dart'; // Adjust the path if necessary
import 'dart:typed_data';
import 'package:logger/logger.dart';

class PostStorage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final StorageMethods _storageMethods = StorageMethods(); // Create an instance of StorageMethods
  final Logger _logger = Logger(); // Logger instance for logging errors

  /// Uploads a post to Firestore.
  Future<String> uploadPost(
    String caption,
    String uid,
    String username,
    String profImage,
    Uint8List image,
  ) async {
    try {
      // Upload the image to storage and get the URL
      String imageUrl = await _storageMethods.uploadImageToStorage(
        isPost: true, // Set to true since it's for a post
        childName: 'posts', // Specify a child name, e.g., 'posts'
        file: image,
      );

      // Create a post document in Firestore
      await _firestore.collection('posts').add({
        'caption': caption,
        'uid': uid,
        'username': username,
        'profImage': profImage,
        'imageUrl': imageUrl,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return "Ok"; // Return success message
    } catch (e) {
      return e.toString(); // Return error message
    }
  }

  /// Deletes a post from Firestore.
  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete(); // Delete the post document
    } catch (e) {
      _logger.e("Error deleting post: $e"); // Log error message
    }
  }
}
