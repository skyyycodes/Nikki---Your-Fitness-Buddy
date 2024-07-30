import 'package:gemini_chat_app_tutorial/Workout/models/exercise.dart';

class Workout {
  final String name;
  final List<Exercise> exercises;

  Workout({
    required this.name,
    required this.exercises,
  });
}
