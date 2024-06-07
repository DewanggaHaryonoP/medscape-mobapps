import 'package:flutter/material.dart';
import 'package:medscape/screens/login_screen.dart';
import '../global_variables.dart';
import 'email_verification_screen.dart'; // Import the VerifSuccessScreen

class VerifSuccessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: VerifSuccessScreen(),
    );
  }
}

class VerifSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Medscape',
                  style: TextStyle(
                    fontFamily: logoFont,
                    fontWeight: FontWeight.bold,
                    fontSize: 32,
                    color: white,
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'icons/success1.png',
                        height: 100,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Verification Successful!',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'SF Pro Display',
                          fontSize: 36,
                          color: white,
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          // Define the action for the button, e.g. navigate to home screen
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()),
                          );
                          ;
                        },
                        child: Text('Back to Log in'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Button color
                          foregroundColor: white, // Text color
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
