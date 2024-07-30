import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gemini_chat_app_tutorial/Workout/components/exercise_tile.dart';
import 'package:gemini_chat_app_tutorial/Workout/data/workout_data.dart';
import 'package:gemini_chat_app_tutorial/Workout/pages/home_page2.dart';
import 'package:gemini_chat_app_tutorial/Homepage/speech_screen.dart';
import 'package:gemini_chat_app_tutorial/Diet%20page/Diet_page.dart';
import 'package:gemini_chat_app_tutorial/Episodes%20page/episode_page.dart';
import 'package:gemini_chat_app_tutorial/Doctor%20Chat/doctor_chat.dart';
import 'package:gemini_chat_app_tutorial/Profile%20page/Profile_page.dart';

// Define a color scheme
final Color primaryColor = Colors.blueAccent;
final Color backgroundColor = Colors.blueGrey[50]!;

class WorkoutPage extends StatefulWidget {
  final String workoutName;
  const WorkoutPage({super.key, required this.workoutName});

  @override
  State<WorkoutPage> createState() => _WorkoutPageState();
}

class _WorkoutPageState extends State<WorkoutPage> {
  int _selectedIndex = 2; // Default to HomePage2

  final List<Widget> _pages = [
    EpisodesPage(),
    SpeechScreen(),
    HomePage2(), // Home page
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

  void onCheckBoxChanged(String workoutName, String exerciseName) {
    Provider.of<WorkoutData>(context, listen: false)
        .checkOffExercise(workoutName, exerciseName);
  }

  // text controllers
  final exerciseNameController = TextEditingController();
  final weightController = TextEditingController();
  final repsController = TextEditingController();
  final setsController = TextEditingController();

  void createNewExercise() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Add a new Exercise'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // exercise name
                  TextField(
                    controller: exerciseNameController,
                    decoration: InputDecoration(
                      labelText: 'Exercise Name',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  // weight
                  TextField(
                    controller: weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  // reps
                  TextField(
                    controller: repsController,
                    decoration: InputDecoration(
                      labelText: 'Reps',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 10),
                  // sets
                  TextField(
                    controller: setsController,
                    decoration: InputDecoration(
                      labelText: 'Sets',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                // save button
                MaterialButton(
                  onPressed: save,
                  color: primaryColor,
                  textColor: Colors.white,
                  child: Text("Save"),
                ),
                // cancel button
                MaterialButton(
                  onPressed: cancel,
                  child: Text("Cancel"),
                ),
              ],
            ));
  }

  void save() {
    String newExerciseName = exerciseNameController.text;
    String weight = weightController.text;
    String reps = repsController.text;
    String sets = setsController.text;
    Provider.of<WorkoutData>(context, listen: false)
        .addExercise(widget.workoutName, newExerciseName, weight, reps, sets);

    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    exerciseNameController.clear();
    weightController.clear();
    repsController.clear();
    setsController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<WorkoutData>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(widget.workoutName),
          backgroundColor: primaryColor,
        ),
        body: ListView.builder(
          itemCount: value.numberOfExercisesInWorkout(widget.workoutName),
          itemBuilder: (context, index) => ExerciseTile(
            exerciseName: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .name,
            weight: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .weight,
            reps: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .reps,
            sets: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .sets,
            isCompleted: value
                .getRelevantWorkout(widget.workoutName)
                .exercises[index]
                .isCompleted,
            onCheckBoxChanged: (val) => onCheckBoxChanged(
                widget.workoutName,
                value
                    .getRelevantWorkout(widget.workoutName)
                    .exercises[index]
                    .name),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: createNewExercise, child: Icon(Icons.add)),
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
