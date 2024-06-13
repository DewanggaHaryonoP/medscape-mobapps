import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'drugs_detail.dart';
import '../global_variables.dart';

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
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('obat')
            .orderBy('name')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData) {
            return Center(child: Text('No data available'));
          }

          var drugs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: drugs.length,
            itemBuilder: (context, index) {
              var drug = drugs[index];
              return DrugsItem(
                name: drug['name'],
                documentId: drug.id,
              );
            },
          );
        },
      ),
    );
  }
}

class DrugsItem extends StatelessWidget {
  final String name;
  final String documentId;

  DrugsItem({required this.name, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DrugInfoPage(documentId: documentId),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Colors.white, fontFamily: bodyFont, fontSize: 16),
            ),
            SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
