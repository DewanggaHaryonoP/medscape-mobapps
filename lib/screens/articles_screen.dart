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
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue,
        elevation: 0,
        toolbarHeight: 80.0,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Spacer(),
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4.0,
                      offset: Offset(2.0, 2.0),
                    ),
                  ],
                ),
                child: TextField(
                  style: TextStyle(color: grey, fontFamily: bodyFont),
                  decoration: InputDecoration(
                    hintText: 'Search Article..',
                    hintStyle: TextStyle(color: grey, fontFamily: bodyFont),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: grey),
                    filled: true,
                    fillColor: darklightblue,
                  ),
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      backgroundColor: grey,
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('articles').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final articles = snapshot.data!.docs;
          return ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  NewsItem(
                    articleId: articles[index].id,
                    title: articles[index]['title'],
                    author: articles[index]['author'],
                    date: articles[index]['date'],
                  ),
                  Divider(
                    color: Colors.grey,
                    thickness: 1.5,
                  ),
                ],
              );
            },
          );
        },
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF536976), Color(0xFF292E49)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10.0,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            _buildNavItem(Icons.home, 'Home', 0, context),
            _buildNavItem(Icons.article, 'Article', 1, context),
            _buildNavItem(Icons.local_pharmacy, 'Drugs', 2, context),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
      IconData icon, String label, int index, BuildContext context) {
    bool isSelected = index == 1;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isSelected ? 8 : 0),
              topRight: Radius.circular(isSelected ? 8 : 0),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 30,
                color: isSelected ? Color(0xFF008080) : Colors.teal,
              ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Color(0xFF008080) : Colors.teal,
                ),
              ),
            ],
          ),
        ),
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
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: bodyFont,
                              fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '$author | $date',
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: bodyFont,
                              fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.grey, // Placeholder for the image
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.bookmark_border, color: teal),
                  SizedBox(width: 10),
                  Icon(Icons.share, color: teal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
