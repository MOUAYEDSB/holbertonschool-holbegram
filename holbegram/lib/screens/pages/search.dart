import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Search extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<Search> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _fetchPosts(); // Fetch posts when the page is initialized
  }

  Future<void> _fetchPosts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('posts').get();
      setState(() {
        _posts = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      });
    } catch (e) {
      print("Error fetching posts: $e"); // Handle errors
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
      ),
      body: _posts.isEmpty
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : StaggeredGridView.countBuilder(
              crossAxisCount: 2, // Number of columns
              itemCount: _posts.length,
              itemBuilder: (BuildContext context, int index) {
                String imageUrl = _posts[index]['imageUrl'] ?? ''; // Get image URL
                return Container(
                  margin: EdgeInsets.all(4.0), // Space between items
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover, // Cover the entire container
                    ),
                  ),
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1), // Each tile takes one column
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
            ),
    );
  }
}
