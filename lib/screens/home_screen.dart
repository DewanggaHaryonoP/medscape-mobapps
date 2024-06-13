import 'package:flutter/material.dart';
import '../global_variables.dart';
import 'articles_screen.dart'; // Import the ArticlesPage

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      appBar: AppBar(
        backgroundColor: black,
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.person, color: white),
            Expanded(
              child: TextField(
                style: TextStyle(color: white, fontFamily: bodyFont),
                decoration: InputDecoration(
                  hintText: 'Search Here...',
                  hintStyle: TextStyle(color: white, fontFamily: bodyFont),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: white),
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.mail, color: white),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'For You',
                  style: TextStyle(
                      color: white, fontFamily: bodyFont, fontSize: 18),
                ),
                Row(
                  children: [
                    Text(
                      'Medscape Today',
                      style: TextStyle(
                          color: teal, fontFamily: bodyFont, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Customize Topics',
                      style: TextStyle(
                          color: white, fontFamily: bodyFont, fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              height: 150,
              color: Colors.grey, // Placeholder for the ad container
              child: Center(
                child: Text(
                  'Ad Space',
                  style: TextStyle(
                      color: white, fontFamily: bodyFont, fontSize: 18),
                ),
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 4, // Adjust based on the number of items
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      color: darkGrey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            color: Colors.grey, // Placeholder for the image
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'News title goes here like this\nNews title goes here like this',
                              style:
                                  TextStyle(color: white, fontFamily: bodyFont),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Medscape Medical News | 4 June 2024',
                                  style: TextStyle(
                                      color: white, fontFamily: bodyFont),
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.bookmark_border, color: white),
                                    SizedBox(width: 10),
                                    Icon(Icons.share, color: white),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: black,
        selectedItemColor: teal,
        unselectedItemColor: white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_pharmacy),
            label: 'Drugs',
          ),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticlesPage()),
            );
          }
        },
      ),
    );
  }
}
