import 'package:flutter/material.dart';
import 'screens/ArticlesPage.dart';

void main() {
  runApp(Articles());
}

class Articles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArticlesPage(),
    );
  }
}
