import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/email_verification_screen.dart';
import 'screens/signup_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medscape',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
    );
  }
}
