import 'package:gemini_chat_app_tutorial/Workout2/pages/details/widgets/stats.dart';
import 'package:gemini_chat_app_tutorial/Workout2/pages/details/widgets/appbar.dart';
import 'package:gemini_chat_app_tutorial/Workout2/pages/details/widgets/dates.dart';
import 'package:gemini_chat_app_tutorial/Workout2/pages/details/widgets/graph.dart';
import 'package:gemini_chat_app_tutorial/Workout2/pages/details/widgets/info.dart' hide Stats;
import 'package:gemini_chat_app_tutorial/Workout2/pages/details/widgets/steps.dart';
import 'package:flutter/material.dart';

class DetailsPage2 extends StatelessWidget {
  const DetailsPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MainAppBar(appBar: AppBar()),
      body: const Column(
        children: [
          Dates(),
          Steps(),
          Graph(),
          Info(),
          Divider(height: 30),
          Stats(),
          SizedBox(height: 30),
        ],
      ),
    );
  }
}
