import 'dart:core';
import 'package:hive/hive.dart';
import 'package:gemini_chat_app_tutorial/Workout/models/exercise.dart';
import 'package:gemini_chat_app_tutorial/Workout/models/workout.dart';
import 'package:gemini_chat_app_tutorial/Workout/date_time/date_time.dart';

class HiveDatabase {
  final _myBox = Hive.box("workout_database1");

  bool previousDataExists() {
    if (_myBox.isEmpty) {
      print("previous data does NOT exist");
      _myBox.put("START_DATE", todaysDateYYYYMMDD());
      return false;
    } else {
      print("Previous Data does Exist");
      return true;
    }
  }

  String getStartDate() {
    return _myBox.get("START_DATE");
  }

  void saveToDatabase(List<Workout> workouts) {
    final workoutList = convertObjectToWorkoutList(workouts);
    final exerciseList = convertObjectToExerciseList(workouts);

    if (exerciseCompleted(workouts)) {
      _myBox.put("COMPLETION_STATUS_" + todaysDateYYYYMMDD(), 1);
    } else {
      _myBox.put("COMPLETION_STATUS_" + todaysDateYYYYMMDD(), 0);
    }

    _myBox.put("WORKOUTS", workoutList);
    _myBox.put("EXERCISES", exerciseList);
  }

  List<Workout> readFromDatabase() {
    List<Workout> mySavedWorkouts = [];
    List<dynamic> workoutNamesDynamic =
        _myBox.get("WORKOUTS", defaultValue: []);
    List<dynamic> exerciseDetailsDynamic =
        _myBox.get("EXERCISES", defaultValue: []);

    if (workoutNamesDynamic is List<String> &&
        exerciseDetailsDynamic is List<List<List<String>>>) {
      List<String> workoutNames = List<String>.from(workoutNamesDynamic);
      List<List<List<String>>> exerciseDetails =
          List<List<List<String>>>.from(exerciseDetailsDynamic);

      for (int i = 0; i < workoutNames.length; i++) {
        List<Exercise> exerciseInEachWorkout = [];
        for (int j = 0; j < exerciseDetails[i].length; j++) {
          exerciseInEachWorkout.add(
            Exercise(
              name: exerciseDetails[i][j][0],
              weight: exerciseDetails[i][j][1],
              reps: exerciseDetails[i][j][2],
              sets: exerciseDetails[i][j][3],
              isCompleted: exerciseDetails[i][j][4] == "true",
            ),
          );
        }
        Workout workout =
            Workout(name: workoutNames[i], exercises: exerciseInEachWorkout);
        mySavedWorkouts.add(workout);
      }
    } else {
      print("Error: Data format in Hive is incorrect.");
    }
    return mySavedWorkouts;
  }

  bool exerciseCompleted(List<Workout> workouts) {
    for (var workout in workouts) {
      for (var exercise in workout.exercises) {
        if (exercise.isCompleted) {
          return true;
        }
      }
    }
    return false;
  }

  int getCompletionStatus(String yyyymmdd) {
    return _myBox.get("COMPLETION_STATUS_$yyyymmdd") ?? 0;
  }
}

List<String> convertObjectToWorkoutList(List<Workout> workouts) {
  List<String> workoutList = [];
  for (var workout in workouts) {
    workoutList.add(workout.name);
  }
  return workoutList;
}

List<List<List<String>>> convertObjectToExerciseList(List<Workout> workouts) {
  List<List<List<String>>> exerciseList = [];
  for (var workout in workouts) {
    List<Exercise> exerciseInWorkout = workout.exercises;
    List<List<String>> individualWorkout = [];
    for (var exercise in exerciseInWorkout) {
      List<String> individualExercise = [
        exercise.name,
        exercise.weight,
        exercise.reps,
        exercise.sets,
        exercise.isCompleted.toString(),
      ];
      individualWorkout.add(individualExercise);
    }
    exerciseList.add(individualWorkout);
  }
  return exerciseList;
}
