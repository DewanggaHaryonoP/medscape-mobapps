import 'package:flutter/material.dart';
import '../global_variables.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Medscape',
                style: TextStyle(
                  fontFamily: logoFont,
                  fontSize: 32,
                  color: white,
                ),
              ),
              SizedBox(height: 40),
              TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: darkGrey,
                  hintText: 'Email',
                  hintStyle: TextStyle(color: white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(color: white, fontFamily: bodyFont),
              ),
              SizedBox(height: 20),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: darkGrey,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: Icon(Icons.visibility, color: white),
                ),
                style: TextStyle(color: white, fontFamily: bodyFont),
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: teal, fontFamily: bodyFont),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: teal,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      color: black,
                      fontFamily: bodyFont,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: Text(
                  "Don't have an account? Create Account",
                  style: TextStyle(color: teal, fontFamily: bodyFont),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Your information is safe and secure.',
                style: TextStyle(color: white, fontFamily: bodyFont),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Contact Support',
                  style: TextStyle(color: teal, fontFamily: bodyFont),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
