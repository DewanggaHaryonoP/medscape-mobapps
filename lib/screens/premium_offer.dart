import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../global_variables.dart';

void main() {
  runApp(PremiumOfferApp());
}

class PremiumOfferApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PremiumOfferScreen(),
    );
  }
}

class PremiumOfferScreen extends StatefulWidget {
  @override
  PremiumOfferScreenState createState() => PremiumOfferScreenState();
}

class PremiumOfferScreenState extends State<PremiumOfferScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Medscape',
                  style: TextStyle(
                    fontFamily: logoFont,
                    fontSize: 32,
                    color: white,
                  ),
                ),
              ),
              // Spacer(),
              SizedBox(
                height: 170,
              ),
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Premium\nSubscription',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontWeight: FontWeight.bold,
                        fontSize: 36,
                        color: white,
                        height: 0.8,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Discover the best features\nMedscape can offer to you!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontStyle: FontStyle.italic,
                        fontSize: 12,
                        color: white,
                      ),
                    ),
                    SizedBox(height: 10),
                    // slideable cards here
                    SizedBox(
                      height: 128,
                      child: PageView(
                        controller: _pageController,
                        onPageChanged: (int page) {
                          setState(() {
                            _currentPage = page;
                          });
                        },
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/icons/unlock1.png',
                                  height: 48),
                              Text(
                                textAlign: TextAlign.center,
                                'Unlock all content',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/icons/recent1.png',
                                  height: 48),
                              Text(
                                textAlign: TextAlign.center,
                                'Latest news and expert\nperspectives',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/icons/info1.png', height: 48),
                              Text(
                                textAlign: TextAlign.center,
                                'Essential info about drugs, diseases,\nand medical tools',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset('assets/icons/roundcast1.png',
                                  height: 48),
                              Text(
                                textAlign: TextAlign.center,
                                'Free CME and professional\nonline education',
                                style: TextStyle(
                                  fontFamily: 'SF Pro Display',
                                  fontSize: 20,
                                  color: white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List<Widget>.generate(4, (int index) {
                        return AnimatedContainer(
                          duration: Duration(milliseconds: 120),
                          margin: EdgeInsets.symmetric(horizontal: 4.0),
                          height: 8.0,
                          width: _currentPage == index ? 24.0 : 6.0,
                          decoration: BoxDecoration(
                            color: _currentPage == index ? teal : Colors.grey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Start 7-day FREE trial',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              height: 0.0,
                              color: grey,
                            ),
                          ),
                          Text(
                            '(then \$7.99/mo if not cancelled)',
                            style: TextStyle(
                              fontFamily: 'SF Pro Display',
                              fontSize: 12,
                              color: grey,
                            ),
                          ),
                        ],
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: teal,
                        // foregroundColor: black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/home');
                      },
                      child: Text('Continue without premium'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: grey,
                        foregroundColor: teal,
                      ),
                    ),
                  ],
                ),
              ),
              // Spacer(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      textAlign: TextAlign.center,
                      'You can cancel your subscription at any time.\n\n We understand that your flexibility is important, which is why we\'ve made it easy for you to cancel your subscription whenever you choose. There are no long term commitments or hidden fees. If at any point you decide that our premium service isn\'t right for you, simply navigate to your account settings and follow the straightforward cancellation process. Your access to premium features will continue until the end of your current billing cycle, ensuring you get the most out of your subscription. Our goal is to provide you with the best experience possible, on your terms.',
                      style: TextStyle(
                        fontFamily: 'SF Pro Display',
                        fontStyle: FontStyle.italic,
                        fontSize: 10,
                        color: white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
