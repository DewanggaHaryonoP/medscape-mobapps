import 'package:flutter/material.dart';
import '../global_variables.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
  bool _rememberMe = false;

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
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: darkGrey,
                  hintText: 'Password',
                  hintStyle: TextStyle(color: white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                style: TextStyle(color: white, fontFamily: bodyFont),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (value) {
                          setState(() {
                            _rememberMe = value!;
                          });
                        },
                        activeColor: teal,
                        checkColor: black,
                      ),
                      Text(
                        'Remember Me',
                        style: TextStyle(color: white, fontFamily: bodyFont),
                      ),
                    ],
                  ),
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: teal, fontFamily: bodyFont),
                  ),
                ],
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement login action
                  },
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUpScreen()),
                  );
                },
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
