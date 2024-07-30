import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:gemini_chat_app_tutorial/Homepage/speech_screen.dart';
import 'package:gemini_chat_app_tutorial/Diet%20page/Diet_page.dart';
import 'package:gemini_chat_app_tutorial/Episodes%20page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Doctor%20Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/Profile%20page/Profile_page.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  File? _image;
  DateTime _joiningDate = DateTime.now(); // Default to current date

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future<void> _selectJoiningDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _joiningDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null && pickedDate != _joiningDate) {
      setState(() {
        _joiningDate = pickedDate;
      });
    }
  }

  void _logout() {
    // Implement your logout functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Logged out')),
    );
  }

  void _goToNextScreen() {
    // Implement your next screen functionality here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Navigating to next screen')),
    );
  }

  int _selectedIndex = 4;

  final List<Widget> _pages = [
    EpisodesPage(),
    SpeechScreen(), // Make sure to import SpeechScreen
    DietPage(),
    ChatWithDoctorPage(),
    EditProfileScreen(), // Current page
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
    final Color primaryColor = Colors.blue[800]!;
    final Color secondaryColor = Colors.blue[50]!;
    final Color accentColor = Colors.orange[800]!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Center(
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: _image != null
                                ? FileImage(_image!) as ImageProvider
                                : null, // No default image
                            child: _image == null
                                ? Icon(Icons.person,
                                    size: 50,
                                    color: primaryColor) // Placeholder icon
                                : null,
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: IconButton(
                              icon: Icon(Icons.camera_alt,
                                  color: accentColor, size: 30),
                              onPressed: _pickImage,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
                        prefixIcon: Icon(Icons.person, color: primaryColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'E-Mail',
                        prefixIcon: Icon(Icons.email, color: primaryColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        labelText: 'Phone No',
                        prefixIcon: Icon(Icons.phone, color: primaryColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock, color: primaryColor),
                        border: OutlineInputBorder(),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: primaryColor),
                        ),
                      ),
                      obscureText: true,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        // Add edit profile functionality here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: accentColor,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      ),
                      child: Text('Edit Profile'),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: _selectJoiningDate,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Joined Date',
                          border: OutlineInputBorder(),
                          suffixIcon:
                              Icon(Icons.calendar_today, color: primaryColor),
                        ),
                        child: Text(
                          '${_joiningDate.toLocal()}'.split(
                              ' ')[0], // Display the date in YYYY-MM-DD format
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20), // Add space below the buttons if needed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: _logout,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Log Out'),
                ),
                ElevatedButton(
                  onPressed: _goToNextScreen,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text('Next'),
                ),
              ],
            ),
            SizedBox(height: 20), // Add space below the buttons if needed
          ],
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
        backgroundColor: primaryColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[700],
      ),
    );
  }
}
