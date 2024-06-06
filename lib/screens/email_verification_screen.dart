import 'package:flutter/material.dart';

class EmailVerificationScreen extends StatelessWidget {
  final String emailAddress;

  EmailVerificationScreen({required this.emailAddress});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Medscape',
              style: TextStyle(
                fontSize: 32,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 32),
            Icon(
              Icons.mark_email_read_outlined,
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
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'We’ve sent an email to ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    baseline: TextBaseline.ideographic,
                    child: GestureDetector(
                      onTap: () {
                      },
                      child: Text(
                        '$emailAddress',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.tealAccent,
                        ),
                      ),
                    ),
                  ),
                  TextSpan(
                    text: ' to verify your email address and activate your account. The link in the email will expire in 24 hours.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Handle click here action
              },
              child: Column(
                children: [
                  Text(
                    'Click Here',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.tealAccent,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                  Text(
                    'if you did not receive the email or wants to change email address previously signed up with.',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 32),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle confirm email action
              },
              child: Text(
                'I’ve confirmed my email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onPressed: () {
                // Handle back to log in action
              },
              child: Text(
                'Back to log in',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}