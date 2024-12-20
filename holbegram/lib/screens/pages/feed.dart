import 'package:flutter/material.dart';
import '../../models/posts.dart';

class Feed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Holbegram',
          style: TextStyle(
            fontFamily: 'Billabong',
            fontSize: 30,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.message),
            onPressed: () {},
          ),
        ],
      ),
      body: Posts(),
    );
  }
}
