import 'package:flutter/material.dart';
import '../global_variables.dart';
import 'articles_screen.dart'; // Import the ArticlesPage
import 'drugs_screen.dart'; // Import the DrugsScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTopIndex = 0;
  int _selectedIndex = 0;

  void _onTopItemTapped(int index) {
    setState(() {
      _selectedTopIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 1) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue, // darklightblue
        elevation: 0,
        toolbarHeight: 80, // Adjust the height of the AppBar
        title: Row(
          children: [
            Icon(Icons.person, color: teal, size: 30), // teal and bigger
            Spacer(), // Add space before the search bar
            Expanded(
              flex:
                  4, // Adjust the flex value to control the width of the search bar
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
                    hintText: 'Search Here...',
                    hintStyle: TextStyle(color: grey, fontFamily: bodyFont),
                    border: InputBorder.none,
                    prefixIcon: Icon(Icons.search, color: grey),
                    filled: true,
                    fillColor: darklightblue, // darkblue
                  ),
                ),
              ),
            ),
            Spacer(), // Add space after the search bar
            IconButton(
              icon: Icon(Icons.mail, color: teal, size: 30), // teal and bigger
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 16.0, top: 16.0), // Padding from top
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTopNavItem('For You', 0),
                  _buildTopNavItem('Medscape Today', 1),
                  Row(
                    children: [
                      Icon(Icons.edit, color: teal, size: 18), // Pencil icon
                      SizedBox(width: 5),
                      Text(
                        'Customize Topics',
                        style: TextStyle(
                            color: teal, fontFamily: bodyFont, fontSize: 12),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 5, // Total number of items (4 articles + 1 ad)
                itemBuilder: (context, index) {
                  if (index == 2) {
                    return Column(
                      children: [
                        Container(
                          height: 150,
                          color:
                              Colors.grey, // Placeholder for the ad container
                          child: Center(
                            child: Text(
                              'Ad Space',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: bodyFont,
                                  fontSize: 12),
                            ),
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.5, // Line break thickness
                        ), // Line break after the ad
                      ],
                    );
                  } else {
                    return Column(
                      children: [
                        Container(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'News title goes here like this\nNews title goes here like this',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: bodyFont,
                                                fontSize: 16),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            'Medscape Medical News | 4 June 2024',
                                            style: TextStyle(
                                                color: Colors.white,
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
                                    color: Colors
                                        .grey, // Placeholder for the image
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: Colors.grey,
                          thickness: 1.5, // Line break thickness
                        ), // Line break between articles
                      ],
                    );
                  }
                },
              ),
            ),
          ],
        ),
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
            _buildNavItem(Icons.home, 'Home', 0),
            _buildNavItem(Icons.article, 'Article', 1),
            _buildNavItem(Icons.local_pharmacy, 'Drugs', 2),
          ],
        ),
      ),
    );
  }

  Widget _buildTopNavItem(String label, int index) {
    bool isSelected = _selectedTopIndex == index;
    return GestureDetector(
      onTap: () => _onTopItemTapped(index),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: isSelected ? darkGrey : teal,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? teal : grey,
            fontFamily: bodyFont,
            fontSize: 12, // Adjust the font size here
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    bool isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => _onItemTapped(index),
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
                color: isSelected ? teal : teal,
              ),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? teal : teal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
