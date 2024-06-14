import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medscape/global_variables.dart';
import 'package:medscape/screens/verif_success.dart'; // Import the VerifSuccessScreen

class EmailVerificationScreen extends StatefulWidget {
  final String emailAddress;

  EmailVerificationScreen({required this.emailAddress});

  @override
  _EmailVerificationScreenState createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _auth = FirebaseAuth.instance;
  bool _isVerifying = false;
  bool _isEmailVerified = false;
  late String _currentEmailAddress;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _currentEmailAddress = widget.emailAddress;
    _checkEmailVerified();
  }

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }

  Future<void> _checkEmailVerified() async {
    if (_isVerifying) return;

    setState(() {
      _isVerifying = true;
    });

    User? user = _auth.currentUser;
    await user?.reload();
    user = _auth.currentUser;

    if (_isDisposed) return;

    if (user != null && user.emailVerified) {
      if (!mounted) return;
      setState(() {
        _isEmailVerified = true;
        _isVerifying = false;
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => VerifSuccessScreen(),
        ),
      );
    } else {
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
      });
      Future.delayed(Duration(seconds: 5), () {
        if (mounted && !_isDisposed) {
          _checkEmailVerified();
        }
      });
    }
  }

  Future<void> _resendVerificationEmail() async {
    try {
      User? user = _auth.currentUser;
      if (user == null) throw Exception("No current user");
      await user.sendEmailVerification();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Verification email resent! Check your inbox.'),
        ),
      );
    } catch (e, stacktrace) {
      print("Error sending email verification: $e");
      print("Stacktrace: $stacktrace");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content:
              Text('Failed to resend verification email. Please try again.'),
        ),
      );
    }
  }

  Future<void> _changeEmailAddress() async {
    TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Change Email Address'),
        content: TextField(
          controller: emailController,
          decoration: InputDecoration(hintText: "Enter new email address"),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              String newEmail = emailController.text.trim();
              if (newEmail.isNotEmpty) {
                try {
                  User? user = _auth.currentUser;
                  if (user == null) throw Exception("No current user");

                  await user.verifyBeforeUpdateEmail(newEmail);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Verification email sent to $newEmail.'),
                    ),
                  );
                  Navigator.of(context).pop();
                  setState(() {
                    _currentEmailAddress = newEmail;
                  });

                  // Update the email verification process for the new email
                  _checkEmailVerified();
                } catch (e, stacktrace) {
                  print("Error updating email: $e");
                  print("Stacktrace: $stacktrace");
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text('Failed to update email. Please try again.'),
                    ),
                  );
                }
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 32),
            Text(
              'Medscape',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: logoFont,
              ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.email_outlined,
                  size: 80,
                  color: Colors.white,
                ),
                SizedBox(height: 32),
                Text(
                  'Verify your email',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'We’ve sent an email to $_currentEmailAddress to verify your email address and activate your account. The link in the email will expire in 24 hours.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Wrong email? ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.none,
                    ),
                    children: [
                      TextSpan(
                        text: 'Click here',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.tealAccent,
                          decoration: TextDecoration.underline,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = _changeEmailAddress,
                      ),
                      TextSpan(
                        text: ' to change your email address.',
                        style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Spacer(),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: _resendVerificationEmail,
                child: Text(
                  'Resend Email Verification',
                  style: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: teal,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                onPressed: () {
                  // Handle back to log in action
                  Navigator.pop(context);
                },
                child: Text(
                  'Back to log in',
                  style: TextStyle(
                    color: grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
