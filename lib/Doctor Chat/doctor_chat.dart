import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/Homepage/speech_service.dart';
import 'package:gemini_chat_app_tutorial/Diet%20page/Diet_page.dart';
import 'package:gemini_chat_app_tutorial/Workout/pages/home_page2.dart';
import 'package:gemini_chat_app_tutorial/Episodes%20page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Profile%20page/Profile_page.dart';
import 'package:gemini_chat_app_tutorial/Homepage/speech_screen.dart';

// Define color scheme
final Color primaryColor = Colors.blueAccent;
final Color secondaryColor = Colors.white;
final Color doctorBubbleColor = Colors.grey[300]!;
final Color userBubbleColor = Colors.blue[100]!;
final Color doctorTextColor = Colors.black;
final Color userTextColor = Colors.blue[800]!;

class ChatWithDoctorPage extends StatefulWidget {
  @override
  _ChatWithDoctorPageState createState() => _ChatWithDoctorPageState();
}

class _ChatWithDoctorPageState extends State<ChatWithDoctorPage> {
  int _selectedIndex = 3;

  final List<Widget> _pages = [
    EpisodesPage(),
    SpeechScreen(), // Make sure to import SpeechScreen
    DietPage(),
    ChatWithDoctorPage(), // Current page
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://example.com/doctor-profile.jpg'), // Doctor's profile image
            ),
            SizedBox(width: 10),
            Text('Dr. John Doe'),
          ],
        ),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.call),
            onPressed: () {
              // Handle call action
            },
            color: secondaryColor,
          ),
          IconButton(
            icon: Icon(Icons.video_call),
            onPressed: () {
              // Handle video call action
            },
            color: secondaryColor,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Example chat bubbles
                ChatBubble(
                  text: "Hello, how can I help you today?",
                  isDoctor: true,
                ),
                ChatBubble(
                  text: "I have a question about my diet.",
                  isDoctor: false,
                ),
                // Add more ChatBubbles here
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: EdgeInsets.symmetric(horizontal: 15),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle send message action
                  },
                  color: primaryColor,
                ),
              ],
            ),
          ),
        ],
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
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final String text;
  final bool isDoctor;

  ChatBubble({required this.text, required this.isDoctor});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isDoctor ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDoctor ? doctorBubbleColor : userBubbleColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isDoctor ? doctorTextColor : userTextColor,
          ),
        ),
      ),
    );
  }
}
