import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'article_detail.dart';
import '../global_variables.dart';

class ArticlesPage extends StatefulWidget {
  @override
  _ArticlesPageState createState() => _ArticlesPageState();
}

class _ArticlesPageState extends State<ArticlesPage> {
  TextEditingController _searchController = TextEditingController();
  String searchQuery = "";
  ScrollController _scrollController = ScrollController();
  List<DocumentSnapshot> articles = [];
  bool isLoading = false;
  bool hasMore = true;
  int documentLimit = 5;
  DocumentSnapshot? lastDocument;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _loadMoreArticles();
      }
    });
    _loadMoreArticles();
  }

  Future<void> _loadMoreArticles() async {
    if (!isLoading && hasMore) {
      setState(() {
        isLoading = true;
      });

      QuerySnapshot querySnapshot;
      if (lastDocument == null) {
        querySnapshot = await FirebaseFirestore.instance
            .collection('articles')
            .orderBy('date')
            .limit(documentLimit)
            .get();
      } else {
        querySnapshot = await FirebaseFirestore.instance
            .collection('articles')
            .orderBy('date')
            .startAfterDocument(lastDocument!)
            .limit(documentLimit)
            .get();
      }

      if (querySnapshot.docs.length < documentLimit) {
        hasMore = false;
      }

      lastDocument =
          querySnapshot.docs.isNotEmpty ? querySnapshot.docs.last : null;
      articles.addAll(querySnapshot.docs);

      setState(() {
        isLoading = false;
      });
    }
  }

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
                  controller: _searchController,
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value.toLowerCase();
                    });
                  },
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (!isLoading &&
              scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent) {
            _loadMoreArticles();
            return true;
          }
          return false;
        },
        child: ListView.builder(
          controller: _scrollController,
          itemCount: articles.length + (isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == articles.length) {
              return _buildProgressIndicator();
            } else {
              final filteredArticle = articles[index];
              final title = filteredArticle['title'].toString().toLowerCase();
              final author = filteredArticle['author'].toString().toLowerCase();
              final date = filteredArticle['date'].toString().toLowerCase();

              if (searchQuery.isEmpty ||
                  title.contains(searchQuery) ||
                  author.contains(searchQuery) ||
                  date.contains(searchQuery)) {
                return Column(
                  children: [
                    NewsItem(
                      articleId: filteredArticle.id,
                      title: filteredArticle['title'],
                      author: filteredArticle['author'],
                      date: filteredArticle['date'],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 1.5,
                    ),
                  ],
                );
              } else {
                return SizedBox.shrink();
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
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
                SizedBox(width: 16),
                Column(
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      color: Colors.grey, // Placeholder for the image
                      child: Image.network(
                        'https://via.placeholder.com/100',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.bookmark_border, color: teal),
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(Icons.share, color: teal),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
