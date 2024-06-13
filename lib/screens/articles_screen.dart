import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_screen.dart';
import 'article_detail.dart';
import '../global_variables.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue,
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('articles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white)));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final articles = snapshot.data!.docs;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return NewsItem(
                articleId: articles[index].id,
                title: articles[index]['title'],
                author: articles[index]['author'],
                date: articles[index]['date'],
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.cyan),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, color: Colors.cyan),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_hospital, color: Colors.cyan),
            label: 'Drugs',
          ),
        ],
        backgroundColor: darkBlue,
        currentIndex: 1,
        selectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
      ),
    );
  }
}

class NewsItem extends StatelessWidget {
  final String articleId;
  final String title;
  final String author;
  final String date;

  NewsItem({
    required this.articleId,
    required this.title,
    required this.author,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ArticleDetailPage(articleId: articleId),
          ),
        );
      },
      child: Card(
        color: Colors.grey[850],
        margin: EdgeInsets.all(8.0),
        child: ListTile(
          leading: Image.network(
            'https://via.placeholder.com/150',
            width: 100,
            fit: BoxFit.cover,
          ),
          title: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
          subtitle: Text(
            '$author | $date',
            style: TextStyle(color: Colors.grey),
          ),
          trailing: Wrap(
            spacing: 12,
            children: <Widget>[
              Icon(Icons.bookmark_border, color: Colors.white),
              Icon(Icons.share, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
