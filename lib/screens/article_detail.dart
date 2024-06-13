import 'package:flutter/material.dart';
import '../global_variables.dart'; // Ensure the global variables file is imported

class ArticleDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue, // Changed from Colors.teal to darkBlue
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Medscape',
              style: TextStyle(
                  fontFamily:
                      'Serif', // Update this to match the font in your app
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: white),
            ),
            Text(
              'news',
              style: TextStyle(
                  fontFamily:
                      'Serif', // Update this to match the font in your app
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                  color: white),
            ),
            Row(
              children: [
                Icon(Icons.bookmark_border, color: Colors.white),
                SizedBox(width: 16),
                Icon(Icons.share, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Article Title',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Medscape Medical News | 4 June 2024',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'Full article content goes here...',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: cream,
    );
  }
}
