import 'dart:io';
import 'dart:typed_data';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';

import 'package:gemini_chat_app_tutorial/Episodes Page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Doctor Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/chatbot/home_page.dart';
import 'package:gemini_chat_app_tutorial/Profile page/Profile_page.dart';
import 'package:gemini_chat_app_tutorial/Diet Page/diet_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Gemini gemini = Gemini.instance;

  List<ChatMessage> messages = [];

  ChatUser currentUser = ChatUser(id: "0", firstName: "User");
  ChatUser geminiUser = ChatUser(
    id: "1",
    firstName: "Nikki",
    profileImage:
        "https://seeklogo.com/images/G/google-gemini-logo-A5787B2669-seeklogo.com.png",
  );

  int _selectedIndex = 0;

  final List<IconData> _icons = [
    Icons.list,
    Icons.chat,
    Icons.home,
    Icons.chat_bubble,
    Icons.person,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic here based on the selected index
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EpisodesPage()), // Replace with your Episodes page
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  HomePage()), // Replace with your Nikki Chat page
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => DietPage()), // Replace with your Diet page
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ChatWithDoctorPage()), // Replace with your Doctor Chat page
        );
        break;
      case 4:
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  EditProfileScreen()), // Replace with your Profile page
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Nikki Chat",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple.shade800,
      ),
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
        child: _buildUI(),
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: _icons,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.end,
        notchSmoothness: NotchSmoothness.defaultEdge,
        backgroundColor: Colors.deepPurple.shade800,
        activeColor: Colors.white,
        inactiveColor: Colors.grey[700],
        onTap: _onItemTapped,
        splashColor: Colors.blue.shade600,
      ),
    );
  }

  Widget _buildUI() {
    return DashChat(
      inputOptions: InputOptions(
        trailing: [
          IconButton(
            onPressed: _sendMediaMessage,
            icon: const Icon(
              Icons.image,
              color: Colors.white,
            ),
          ),
        ],
        inputTextStyle: TextStyle(color: Colors.white),
        inputDecoration: InputDecoration(
          filled: true,
          fillColor: Colors.deepPurple.shade800.withOpacity(0.8),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide.none,
          ),
          hintText: 'Type a message...',
          hintStyle: TextStyle(color: Colors.white54),
        ),
      ),
      currentUser: currentUser,
      onSend: _sendMessage,
      messages: messages,
      messageOptions: MessageOptions(
        messageDecorationBuilder:
            (ChatMessage msg, ChatMessage? previousMsg, ChatMessage? nextMsg) {
          bool isUser = msg.user.id == currentUser.id;
          return BoxDecoration(
            color: isUser
                ? Colors.deepPurple.shade800.withOpacity(0.8)
                : Colors.purple.shade700.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20.0),
          );
        },
        messageTextBuilder:
            (ChatMessage msg, ChatMessage? previousMsg, ChatMessage? nextMsg) {
          return Text(
            msg.text,
            style: TextStyle(color: Colors.white),
          );
        },
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      String question = chatMessage.text;
      List<Uint8List>? images;
      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }
      gemini
          .streamGenerateContent(
        question,
        images: images,
      )
          .listen((event) {
        ChatMessage? lastMessage = messages.firstOrNull;
        if (lastMessage != null && lastMessage.user == geminiUser) {
          lastMessage = messages.removeAt(0);
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          lastMessage.text += response;
          setState(
            () {
              messages = [lastMessage!, ...messages];
            },
          );
        } else {
          String response = event.content?.parts?.fold(
                  "", (previous, current) => "$previous ${current.text}") ??
              "";
          ChatMessage message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    ImagePicker picker = ImagePicker();
    XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (file != null) {
      ChatMessage chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          )
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
