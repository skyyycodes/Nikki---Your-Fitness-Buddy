import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/Homepage/speech_service.dart';
import 'package:gemini_chat_app_tutorial/Diet%20page/Diet_page.dart';
import 'package:gemini_chat_app_tutorial/Workout/pages/home_page2.dart';
import 'package:gemini_chat_app_tutorial/Episodes%20page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Doctor%20Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/Profile%20page/Profile_page.dart';

// Define a color scheme that matches your SplashScreen
const Color primaryColor = Colors.blueAccent;
const Color secondaryColor = Colors.white;
const Color buttonColor = Colors.deepOrangeAccent;
const Color navBarColor = Colors.blue; // Set your desired blue color

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final SpeechService _speechService = SpeechService();
  String _response = "Say something to Nikki!";

  int _selectedIndex = 1;

  final List<Widget> _pages = [
    EpisodesPage(),
    SpeechScreen(), // Current page
    DietPage(),
    ChatWithDoctorPage(),
    EditProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  void initState() {
    super.initState();
    _speechService.initialize();
  }

  void _handleSpeech(String text) async {
    // Get the custom response
    String response = _speechService.getCustomResponse(text);

    setState(() {
      _response = response;
    });

    await _speechService.speak(response);
  }

  Future<bool> _onWillPop() async {
    // Navigate to DietPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => DietPage()),
    );
    return false; // Prevent default back navigation
  }

  void _navigateToWorkoutPage() {
    // Navigate to HomePage2
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => HomePage2()), // Navigate to HomePage2
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Nikki Voice Interaction'),
          backgroundColor: primaryColor,
        ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor.withOpacity(0.8), secondaryColor],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    _response,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: secondaryColor,
                      shadows: [
                        Shadow(
                          blurRadius: 4.0,
                          color: Colors.black.withOpacity(0.5),
                          offset: Offset(2.0, 2.0),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _speechService.startListening(_handleSpeech);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Start Listening"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      await _speechService.stopListening();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Stop Listening"),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _navigateToWorkoutPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    child: Text("Workout"),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Episodes',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Speech',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Diet',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble),
              label: 'Chat',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          backgroundColor:
              navBarColor, // Set the background color of the navbar
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[700],
        ),
      ),
    );
  }
}
