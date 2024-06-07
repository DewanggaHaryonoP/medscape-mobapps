import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global_variables.dart';
import 'package:medscape/screens/signup_screen.dart';
import 'package:medscape/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medscape/auth/auth_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUserEmailPassword();
  }

  void _loadUserEmailPassword() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('email');
    final password = prefs.getString('password');
    final rememberMe = prefs.getBool('rememberMe') ?? false;

    if (email != null && password != null && rememberMe) {
      setState(() {
        _emailController.text = email;
        _passwordController.text = password;
        _rememberMe = rememberMe;
      });
    }
  }

  Future<void> _saveUserEmailPassword() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('email', _emailController.text);
      await prefs.setString('password', _passwordController.text);
      await prefs.setBool('rememberMe', _rememberMe);
    } else {
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('rememberMe');
    }
  }

  void _login() async {
    final email = _emailController.text;
    final password = _passwordController.text;

    setState(() {
      _error = null;
      _isLoading = true;
    });

    try {
      final user = await _auth.loginUserWithEmailAndPassword(email, password);
      if (user != null) {
        log("User Logged In");
        await _saveUserEmailPassword();
        Navigator.pushNamed(context, '/home'); // Assuming you have a home route
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _error = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          _error = 'Wrong password provided for that user.';
        } else {
          _error = 'Incorrect email or password. Please try again.';
        }
        _isLoading = false;
      });
      log("Login failed: ${e.message}");
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
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
                const SizedBox(height: 40),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: darkGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Log In To Your account',
                        style: TextStyle(
                          color: white,
                          fontFamily: bodyFont,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 5),
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
                      const SizedBox(height: 20),
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
                      const SizedBox(height: 5),
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
                          errorText: _error,
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
                      const SizedBox(height: 10),
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
                                style: TextStyle(
                                    color: white, fontFamily: bodyFont),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context,
                                  '/forgot_password'); // Assuming you have a forgot password route
                            },
                            child: Text(
                              'Forgot Password?',
                              style:
                                  TextStyle(color: teal, fontFamily: bodyFont),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      if (_isLoading)
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(teal),
                        )
                      else
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: teal,
                              padding: const EdgeInsets.symmetric(vertical: 16),
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
                    ],
                  ),
                ),
                const SizedBox(height: 20),
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
                const SizedBox(height: 10),
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
      ),
    );
  }
}
