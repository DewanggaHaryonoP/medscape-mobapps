import 'package:flutter/material.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
          },
        ),
        title: Container(
          height: 40.0,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blueGrey[900],
              hintText: 'Search Article..',
              hintStyle: TextStyle(color: Colors.grey[400]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
            ),
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return NewsItem();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.cyan,),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, color: Colors.cyan,),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital, color: Colors.cyan,),
            label: 'Drugs',
          ),
        ],
        backgroundColor: Colors.teal,
        currentIndex: 1,
        selectedItemColor: Colors.white,
        onTap: (index) {
          // Handle bottom navigation tap
        },
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        leading: Image.network(
          'https://via.placeholder.com/150',
          width: 100,
          fit: BoxFit.cover,
        ),
        title: Text(
          'News title goes here like this',
          style: TextStyle(color: Colors.white),
        ),
        subtitle: Text(
          'Medscape Medical News | 4 June 2024',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Wrap(
          spacing: 12, // space between two icons
          children: <Widget>[
            Icon(Icons.bookmark_border, color: Colors.white),
            Icon(Icons.share, color: Colors.white),
          ],
        ),
      ),
    );
  }
}