import 'package:gemini_chat_app_tutorial/Workout2/pages/home/widgets/activity.dart';
import 'package:gemini_chat_app_tutorial/Workout2/pages/home/widgets/current.dart';
import 'package:gemini_chat_app_tutorial/Workout2/pages/home/widgets/header.dart';
import 'package:flutter/material.dart';

class HomePage3 extends StatelessWidget {
  const HomePage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Home Page'),
      ),
      body: const Column(
        children: [
          AppHeader(),
          CurrentPrograms(),
          RecentActivities(),
        ],
      ),
    );
  }
}
