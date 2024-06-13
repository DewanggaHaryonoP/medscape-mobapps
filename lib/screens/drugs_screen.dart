import 'package:flutter/material.dart';
import 'home_screen.dart'; // Import the HomeScreen
import 'articles_screen.dart';
import 'drugs_detail.dart';
import '../global_variables.dart'; // Ensure the global variables file is imported

void main() {
  runApp(DrugsScreenApp());
}

class DrugsScreenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DrugsScreen(),
    );
  }
}

class DrugsScreen extends StatefulWidget {
  @override
  DrugScreenState createState() => DrugScreenState();
}

class DrugScreenState extends State<DrugsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkBlue, // Changed from Colors.teal to darkBlue
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Handle back button press
          },
        ),
        title: Container(
          height: 40.0,
          child: TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.blueGrey[900],
              hintText: 'Search Drugs..',
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
          return DrugsItem();
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.cyan,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.article,
              color: Colors.cyan,
            ),
            label: 'Article',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.local_hospital,
              color: Colors.cyan,
            ),
            label: 'Drugs',
          ),
        ],
        backgroundColor: darkBlue, // Changed from Colors.teal to darkBlue
        currentIndex: 2,
        selectedItemColor: Colors.white,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          }
          else if (index == 1) {
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

class DrugsItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DrugInfoPage()),
        );
      },
      child: Card(
        color: Colors.grey[850],
        margin: EdgeInsets.all(2.0),
        child: ListTile(
          title: Text(
            'Drugs name goes here..',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
