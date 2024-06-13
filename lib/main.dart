import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/premium_offer.dart'; // Import PremiumOfferScreen

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCYhaD5dJyirL_0yN8Ve5-N-RovWZl4QIQ",
      projectId: "medscape-22cf9",
      messagingSenderId: "443967323027",
      appId: "1:443967323027:web:2357a86478971016390666",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Medscape',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/premium_offer': (context) =>
            PremiumOfferScreen(), // Add PremiumOfferScreen route
      },
    );
  }
}
