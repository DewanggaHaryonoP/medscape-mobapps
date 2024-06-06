import 'package:flutter/material.dart';
import 'screens/email_verification_screen.dart';

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
      home: EmailVerificationScreen(emailAddress: 'example@example.com'),
    );
  }
}
