import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'articles_screen.dart';
import 'home_screen.dart';
import '../global_variables.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Drug Information',
      home: DrugInfoPage(),
    );
  }
}

class DrugInfoPage extends StatefulWidget {
  @override
  _DrugInfoPageState createState() => _DrugInfoPageState();
}

class _DrugInfoPageState extends State<DrugInfoPage> {
  int _selectedTopIndex = 0;
  int _selectedIndex = 2;

  void _onTopItemTapped(int index) {
    setState(() {
      _selectedTopIndex = index;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ArticlesPage()),
      );
    }if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DrugInfoPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkGrey,
      appBar: AppBar(
        backgroundColor: darkBlue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Medscape',
            style: TextStyle(
              fontFamily: logoFont,
              fontSize: 32,
              color: white,
            ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Drug Name',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 8,
              ),
            Text(
              'Alias: ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),SizedBox(
              height: 8,
              ),
            Text(
              'Class: ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: [
                  ExpansionPanelListExample(),
                ],
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
          color: isSelected ? Colors.black : teal,
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

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(int numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      headerValue: index == 0 ? 'Adverse Effects' : 'Warnings',
      expandedValue: index == 0
          ? 'Adverse effects information goes here.'
          : 'Warnings information goes here.',
    );
  });
}

class ExpansionPanelListExample extends StatefulWidget {
  const ExpansionPanelListExample({super.key});

  @override
  State<ExpansionPanelListExample> createState() =>
      _ExpansionPanelListExampleState();
}

class _ExpansionPanelListExampleState extends State<ExpansionPanelListExample> {
  final List<Item> _data = generateItems(2);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerValue),
            );
          },
          body: ListTile(
              title: Text(item.expandedValue),
              ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
