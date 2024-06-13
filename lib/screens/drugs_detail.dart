import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../global_variables.dart';

class DrugInfoPage extends StatelessWidget {
  final String documentId;

  DrugInfoPage({required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: AppBar(
          backgroundColor: darkBlue,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(top: 18.0),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              'Medscape',
              style: TextStyle(
                fontFamily: 'Serif',
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future:
            FirebaseFirestore.instance.collection('obat').doc(documentId).get(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}',
                  style: TextStyle(color: Colors.white)),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          final drugData = snapshot.data!;
          final String name = drugData['name'] ?? '';
          final String alias = drugData['alias'] ?? '';
          final String drugClass = drugData['class'] ?? '';
          final String adverse = drugData['adverse'] ?? '';
          final String warnings = drugData['warning'] ?? '';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontFamily: bodyFont,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Alias: $alias',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: bodyFont,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Class: $drugClass',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: bodyFont,
                  ),
                ),
                SizedBox(height: 16),
                _buildExpansionTile(
                  title: 'Adverse Effects',
                  content: adverse,
                ),
                Divider(color: Colors.white),
                _buildExpansionTile(
                  title: 'Warnings',
                  content: warnings,
                ),
                Divider(color: Colors.white),
              ],
            ),
          );
        },
      ),
      backgroundColor: grey,
    );
  }

  Widget _buildExpansionTile({required String title, required String content}) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isExpanded = false;

        return Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: bodyFont,
              ),
            ),
            trailing: Icon(
              isExpanded ? Icons.arrow_drop_down : Icons.arrow_forward,
              color: Colors.white,
            ),
            onExpansionChanged: (bool expanded) {
              setState(() {
                isExpanded = expanded;
              });
            },
            children: [
              Container(
                color: grey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    content,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontFamily: bodyFont,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
