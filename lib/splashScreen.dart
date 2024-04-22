import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Auth Screens/signUpScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _imageAnimation;
  late Animation<double> _textAnimation;
  double _sliderValue = 0.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _imageAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.0, 0.5, curve: Curves.easeIn)),
    );

    _textAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Interval(0.5, 1.0, curve: Curves.easeIn)),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _navigateToNextScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => SignUpScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FadeTransition(
            opacity: _imageAnimation,
            child: Image.asset('assets/images/indian.png'),
          ),
          const SizedBox(
            height: 20,
          ),
          FadeTransition(
            opacity: _textAnimation,
            child: const Text(
              'TRU NRI',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600, color: Color(0xffFF9933)),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          GestureDetector(
            onPanUpdate: (details) {
              setState(() {
                _sliderValue += details.delta.dx / 300; // Adjust the divisor to control the sensitivity
                _sliderValue = _sliderValue.clamp(0.0, 1.0);
              });
            },
            onPanEnd: (_) {
              if (_sliderValue >= 1.0) {
                _navigateToNextScreen();
              } else {
                setState(() {
                  _sliderValue = 0.0;
                });
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 50,
              decoration: BoxDecoration(
                color: Color(0xff003161),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Stack(
                children: [
                  AnimatedPositioned(
                    duration: Duration(milliseconds: 300),
                    left: _sliderValue * (MediaQuery.of(context).size.width * 0.6),
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: Color(0xffFF9933),
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(25), bottomLeft: Radius.circular(25))),
                        child: Icon(Icons.arrow_forward, color: Colors.white)),
                  ),
                  Center(
                    child: Text(
                      'Next',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
