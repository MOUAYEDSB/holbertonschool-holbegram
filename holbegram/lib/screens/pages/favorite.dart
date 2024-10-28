import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Favorite extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<Favorite> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _favorites = [];

  @override
  void initState() {
    super.initState();
    _fetchFavorites(); // Fetch favorite images on initialization
  }

  Future<void> _fetchFavorites() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('favorites').get(); // Get favorites from Firestore
      setState(() {
        _favorites = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList(); // Convert documents to a list
      });
    } catch (e) {
      print("Error fetching favorites: $e"); // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: _favorites.isEmpty
          ? Center(child: CircularProgressIndicator()) // Loading indicator
          : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Two columns
                childAspectRatio: 1, // Square tiles
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _favorites.length,
              itemBuilder: (context, index) {
                String imageUrl = _favorites[index]['imageUrl'] ?? ''; // Get image URL
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl), // Load image from URL
                      fit: BoxFit.cover, // Cover the entire container
                    ),
                  ),
                );
              },
            ),
    );
  }
}
