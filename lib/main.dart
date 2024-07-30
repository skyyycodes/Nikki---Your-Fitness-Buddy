import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/Details page/Details_page_1.dart';
import 'package:gemini_chat_app_tutorial/Splashscreen/splash_screen.dart';
import 'package:gemini_chat_app_tutorial/Doctor Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/homepage/speech_screen.dart';
import 'package:gemini_chat_app_tutorial/chatbot/home_page.dart';
import 'package:gemini_chat_app_tutorial/Episodes Page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Profile page/Profile_page.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:gemini_chat_app_tutorial/Workout/data/workout_data.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:gemini_chat_app_tutorial/consts.dart';

void main() async {
  Gemini.init(
    apiKey: GEMINI_API_KEY,
  );
  await Hive.initFlutter();
  await Hive.deleteBoxFromDisk(
      'workout_database1'); // Add this line to clear the database
  await Hive.openBox("workout_database1");
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => WorkoutData()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nikki',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LayoutBuilder(
        builder: (context, constraints) {
          return SplashScreen(); // Set the LoginPage as the home page
        },
      ),
      routes: {
        '/details': (context) =>
            UserInfoForm(), // Define the route for the details page
        '/episodes': (context) => EpisodesPage(),
        '/chat': (context) => HomePage(),
        '/home': (context) => SpeechScreen(),
        '/doctor_chat': (context) => ChatWithDoctorPage(),
        '/profile': (context) => EditProfileScreen(),
      },
    );
  }
}
