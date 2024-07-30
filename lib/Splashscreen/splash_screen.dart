import 'package:flutter/material.dart';
import 'dart:async'; // To handle timing functions
import 'package:gemini_chat_app_tutorial/login page/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;
  double _translateY = 50.0; // Start position for the slide-in effect
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2), // Duration for slide-in animation
    );

    // Set the slide-in animation
    _controller.addListener(() {
      setState(() {
        _translateY =
            50.0 * (1 - _controller.value); // Slide in from the bottom
      });
    });

    // Start the animations
    Timer(Duration(milliseconds: 500), () {
      setState(() {
        _opacity = 1.0; // Fade in
      });
      _controller.forward(); // Start the slide-in animation
    });

    // Transition to the next screen after a delay
    Timer(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage()), // Replace with your target page
      );
    });
  }

  @override
  void dispose() {
    _controller
        .dispose(); // Dispose of the controller when the widget is removed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue.shade900,
              Colors.purple.shade700,
              Colors.red.shade500,
            ],
          ),
        ),
        child: Center(
          child: AnimatedOpacity(
            opacity: _opacity,
            duration: Duration(seconds: 1), // Duration for fade-in
            child: AnimatedContainer(
              duration: Duration(seconds: 2), // Duration for slide-in
              curve: Curves.easeInOut,
              child: Transform.translate(
                offset: Offset(0, _translateY),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.flash_on, // Superhero-like icon
                      color: Colors.yellow.shade600,
                      size: 100.0,
                      shadows: [
                        Shadow(
                          offset: Offset(4, 4),
                          blurRadius: 10.0,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'N I K K I',
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            offset: Offset(3, 3),
                            blurRadius: 6.0,
                            color: Colors.black45,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Power Up with Fitness!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w300,
                        color: Colors.white70,
                        shadows: [
                          Shadow(
                            offset: Offset(2, 2),
                            blurRadius: 4.0,
                            color: Colors.black38,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
