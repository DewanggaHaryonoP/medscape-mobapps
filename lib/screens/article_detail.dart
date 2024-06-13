import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global_variables.dart';

class ArticleDetailPage extends StatelessWidget {
  final String articleId;

  ArticleDetailPage({required this.articleId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(70.0), // Increase the height to give more space
        child: AppBar(
          backgroundColor: darkBlue,
          elevation: 0,
          leading: Padding(
            padding:
                const EdgeInsets.only(top: 18.0), // Move the back arrow down
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(
                top: 20.0), // Move the title and icons down
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      'Medscape',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8), // Reduced the gap
                    Text(
                      'news',
                      style: TextStyle(
                        fontFamily: 'Serif',
                        fontSize: 24,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('articles')
            .doc(articleId)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.white)));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final article = snapshot.data!;
          final String firstParagraph = article['first_p'] ?? '';
          final String content = article['content'];
          final List<String> paragraphs = content.split('<br>');

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  article['title'],
                  style: TextStyle(
                    fontFamily: bodyFont,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: grey,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '${article['author']} | ${article['date']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: grey,
                    fontFamily: bodyFont,
                  ),
                ),
                SizedBox(height: 16), // Increased spacing before the first ad
                Container(
                  color: Colors.grey[300],
                  height: 100,
                  child: Center(
                    child: Text('Ad Placeholder',
                        style: TextStyle(color: Colors.black)),
                  ),
                ),
                SizedBox(height: 16), // Increased spacing after the first ad
                Text(
                  firstParagraph,
                  style: TextStyle(
                    fontSize: 16,
                    color: grey,
                    fontFamily: bodyFont,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 16), // Increased spacing before the paragraphs
                for (int i = 0; i < paragraphs.length; i++) ...[
                  Text(
                    paragraphs[i],
                    style: TextStyle(
                      fontSize: 16,
                      color: grey,
                      fontFamily: bodyFont,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  if (i == 0)
                    SizedBox(
                        height:
                            4), // Increased spacing after the first paragraph
                  if (i == 2)
                    Column(
                      children: [
                        SizedBox(
                            height:
                                16), // Increased spacing before the larger ad
                        Container(
                          color: Colors.grey[400],
                          height: 150,
                          child: Center(
                            child: Text('Larger Ad Placeholder',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                        SizedBox(
                            height:
                                16), // Increased spacing after the larger ad
                      ],
                    ),
                  SizedBox(
                      height: 8), // Increased spacing between the paragraphs
                ]
              ],
            ),
          );
        },
      ),
      backgroundColor: cream,
    );
  }
}
