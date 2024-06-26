import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'email_verification_screen.dart'; // Import the EmailVerificationScreen
import 'package:medscape/screens/email_verification_screen.dart'; // Import the EmailVerificationScreen
import 'package:medscape/global_variables.dart';
import 'package:medscape/auth/auth_service.dart'; // Import AuthService

import 'package:flutter/material.dart';
import 'email_verification_screen.dart'; // Import the EmailVerificationScreen
import 'package:medscape/global_variables.dart';
import 'package:medscape/auth/auth_service.dart'; // Import AuthService

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isPasswordVisible = false;
  bool _acceptTerms = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _countryController = TextEditingController();
  bool _isLoading = false; // Track the loading state
  String? _errorMessage; // Error message

  final AuthService _authService =
      AuthService(); // Create an instance of AuthService

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final userCredential = await _authService.createUserWithEmailAndPassword(
        _emailController.text,
        _passwordController.text,
      );
      final user = userCredential?.user;
      if (user != null) {
        await user.sendEmailVerification();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => EmailVerificationScreen(
              emailAddress: _emailController.text,
            ),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message;
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: grey,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
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
                SizedBox(height: 20),
                Text(
                  'Make An Account',
                  style: TextStyle(
                    fontFamily: bodyFont,
                    fontSize: 24,
                    color: white,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Email',
                          style: TextStyle(
                            color: white,
                            fontFamily: bodyFont,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Email',
                          hintStyle: TextStyle(color: darkGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: darkGrey, fontFamily: bodyFont),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Password',
                          style: TextStyle(
                            color: white,
                            fontFamily: bodyFont,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Password',
                          hintStyle: TextStyle(color: darkGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: darkGrey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                        style: TextStyle(color: darkGrey, fontFamily: bodyFont),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Country',
                          style: TextStyle(
                            color: white,
                            fontFamily: bodyFont,
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      TextField(
                        controller: _countryController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Country',
                          hintStyle: TextStyle(color: darkGrey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        style: TextStyle(color: darkGrey, fontFamily: bodyFont),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Checkbox(
                            value: _acceptTerms,
                            onChanged: (value) {
                              setState(() {
                                _acceptTerms = value!;
                              });
                            },
                            activeColor: teal,
                            checkColor: black,
                          ),
                          Expanded(
                            child: Text(
                              'Terms and Condition',
                              style:
                                  TextStyle(color: white, fontFamily: bodyFont),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      _errorMessage != null
                          ? Text(
                              _errorMessage!,
                              style: TextStyle(color: Colors.red),
                            )
                          : Container(),
                      SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_acceptTerms) {
                                    _signup();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content: Text(
                                            'Please accept the terms and conditions.'),
                                      ),
                                    );
                                  }
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: teal,
                            padding: EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(
                                  valueColor:
                                      AlwaysStoppedAnimation<Color>(black),
                                )
                              : Text(
                                  'Sign Up',
                                  style: TextStyle(
                                    color: black,
                                    fontFamily: bodyFont,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
