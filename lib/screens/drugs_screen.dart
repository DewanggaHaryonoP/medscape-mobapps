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
                    hintText: 'Search Drugs..',
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
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return Column(
            children: [
              DrugsItem(),
              Divider(
                color: Colors.grey,
                thickness: 1.5,
              ),
            ],
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
    bool isSelected = index == 2;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ArticlesPage()),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DrugsScreen()),
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
                          'Drugs name goes here..',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: bodyFont,
                              fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Drug description or additional info here.',
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
