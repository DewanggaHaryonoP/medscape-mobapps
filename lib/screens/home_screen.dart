import 'package:flutter/material.dart';
import '../global_variables.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTopIndex = 0;

  void _onTopItemTapped(int index) {
    setState(() {
      _selectedTopIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: darkBlue,
        elevation: 0,
        toolbarHeight: 80,
        title: Row(
          children: [
            Icon(Icons.person, color: teal, size: 30),
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
                    hintText: 'Search Here...',
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
            IconButton(
              icon: Icon(Icons.mail, color: teal, size: 30),
              onPressed: () {},
            ),
          ],
        ),
      ),
      body: HomeContent(
        selectedTopIndex: _selectedTopIndex,
        onTopItemTapped: _onTopItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final int selectedTopIndex;
  final Function(int) onTopItemTapped;

  HomeContent({required this.selectedTopIndex, required this.onTopItemTapped});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTopNavItem('For You', 0),
                _buildTopNavItem('Medscape Today', 1),
                Row(
                  children: [
                    Icon(Icons.edit, color: teal, size: 18),
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
              itemCount: 5,
              itemBuilder: (context, index) {
                if (index == 2) {
                  return Column(
                    children: [
                      Container(
                        height: 150,
                        color: Colors.grey,
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
                        thickness: 1.5,
                      ),
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
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.grey,
                        thickness: 1.5,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavItem(String label, int index) {
    bool isSelected = selectedTopIndex == index;
    return GestureDetector(
      onTap: () => onTopItemTapped(index),
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
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
