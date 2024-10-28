import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import './methods/post_storage.dart'; // Adjust the import as needed
import '../home.dart'; // Adjust the import for your Home page

class AddImage extends StatefulWidget {
  @override
  _AddImagePageState createState() => _AddImagePageState();
}

class _AddImagePageState extends State<AddImage> {
  final ImagePicker _picker = ImagePicker();
  Uint8List? _image; // Variable to store the selected image
  String? _caption; // Variable to store the post caption

  /// Function to pick an image from gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source);
      if (pickedFile != null) {
        // Convert XFile to Uint8List
        _image = await pickedFile.readAsBytes();
        setState(() {}); // Update the UI
      }
    } catch (e) {
      print("Error picking image: $e"); // Handle errors
    }
  }

  /// Function to upload the post
  Future<void> _uploadPost() async {
    if (_image != null && _caption != null && _caption!.isNotEmpty) {
      String uid = 'user_uid'; // Replace with the actual user ID
      String username = 'user_username'; // Replace with the actual username
      String profImage = 'profile_image_url'; // Replace with the actual profile image URL

      PostStorage postStorage = PostStorage();
      String result = await postStorage.uploadPost(
        _caption!,
        uid,
        username,
        profImage,
        _image!,
      );

      if (result == "Ok") {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Home()), // Redirect to Home page
          (Route<dynamic> route) => false,
        );
      } else {
        print("Error uploading post: $result"); // Handle errors
      }
    } else {
      print("Please select an image and enter a caption."); // Validation
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
        actions: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: _uploadPost,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  _caption = value; // Update the caption state
                });
              },
              decoration: InputDecoration(
                hintText: 'Enter caption...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),
            _image != null
                ? Image.memory(_image!) // Display the selected image
                : Text('No image selected.'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.gallery), // Pick from gallery
                  child: Text('Gallery'),
                ),
                ElevatedButton(
                  onPressed: () => _pickImage(ImageSource.camera), // Pick from camera
                  child: Text('Camera'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
