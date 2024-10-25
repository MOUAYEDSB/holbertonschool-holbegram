import 'dart:typed_data';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Upload image to Firebase Storage
  Future<String> uploadImageToStorage(
    bool isPost,
    String childName,
    Uint8List file,
  ) async {
    // Create a reference to the Firebase storage location
    Reference ref = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    
    // If the image is for a post, create a unique ID for it
    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }
    
    // Upload the image
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    
    // Get the download URL of the uploaded image
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }
}
