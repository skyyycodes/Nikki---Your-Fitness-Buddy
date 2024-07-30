import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gemini_chat_app_tutorial/Workout/components/heat_map.dart';
import 'package:gemini_chat_app_tutorial/Workout/data/workout_data.dart';
import 'package:gemini_chat_app_tutorial/Workout/pages/workout_page.dart';
import 'package:gemini_chat_app_tutorial/Homepage/speech_screen.dart';
import 'package:gemini_chat_app_tutorial/Diet%20page/Diet_page.dart';
import 'package:gemini_chat_app_tutorial/Episodes%20page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Doctor%20Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/Profile%20page/Profile_page.dart';

// Define a color scheme
final Color primaryColor = Colors.blueAccent;
final Color secondaryColor = Colors.white;
final Color buttonColor = Colors.deepOrangeAccent;
final Color backgroundColor = Colors.blueGrey[50]!;

class HomePage2 extends StatefulWidget {
  const HomePage2({super.key});
  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    EpisodesPage(),
    SpeechScreen(),
    HomePage2(), // Current page
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
    Provider.of<WorkoutData>(context, listen: false).initializeWorkoutList();
  }

  final newWorkoutNameController = TextEditingController();

  void createNewWorkout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title:
            Text("Create New Workout", style: TextStyle(color: primaryColor)),
        content: TextField(
          controller: newWorkoutNameController,
          decoration: InputDecoration(
            hintText: 'Enter workout name',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        actions: [
          // save button
          ElevatedButton(
            onPressed: save,
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Save"),
          ),
          // cancel button
          ElevatedButton(
            onPressed: cancel,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  // go to new workout page
  void goToWorkoutPage(String workoutName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => WorkoutPage(
          workoutName: workoutName,
        ),
      ),
    );
  }

  void save() {
    String newWorkoutName = newWorkoutNameController.text;
    Provider.of<WorkoutData>(context, listen: false).addWorkout(newWorkoutName);
    Navigator.pop(context);
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newWorkoutNameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: const Text('Workout Tracker'),
          backgroundColor: primaryColor,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: createNewWorkout,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyHeatMap(
                datasets: value.heatMapDataSet,
                startDateYYYYMMDD: value.getStartDate(),
              ),
              SizedBox(height: 20),
              Text(
                'Workout List',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: primaryColor,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: value.getWorkoutList().length,
                  itemBuilder: (context, index) => Card(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    elevation: 5,
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16),
                      title: Text(
                        value.getWorkoutList()[index].name,
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                      trailing: IconButton(
                        icon:
                            Icon(Icons.arrow_forward_ios, color: primaryColor),
                        onPressed: () =>
                            goToWorkoutPage(value.getWorkoutList()[index].name),
                      ),
                    ),
                  ),
                ),
              ),
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
              label: 'Home',
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
      ),
    );
  }
}
