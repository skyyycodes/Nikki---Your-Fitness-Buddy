import 'package:flutter/material.dart';
import 'package:gemini_chat_app_tutorial/Workout/data/hive_database.dart';
import 'package:gemini_chat_app_tutorial/Workout/date_time/date_time.dart';
import 'package:gemini_chat_app_tutorial/Workout/models/exercise.dart';
import '../models/workout.dart';

class WorkoutData extends ChangeNotifier {
  final db = HiveDatabase();
  List<Workout> workoutList = [
    Workout(
      name: "Chest",
      exercises: [
        Exercise(name: "Push up", weight: "No Weight", reps: "10", sets: "3")
      ],
    ),
    Workout(
      name: "Back",
      exercises: [
        Exercise(name: "Pull ups", weight: "No Weight", reps: "10", sets: "3")
      ],
    ),
    Workout(
      name: "Arms",
      exercises: [
        Exercise(
            name: "Bicep Curls", weight: "No Weight", reps: "10", sets: "3")
      ],
    ),
    Workout(
      name: "Legs",
      exercises: [
        Exercise(name: "Squats", weight: "10", reps: "10", sets: "3")
      ],
    ),
    Workout(
      name: "Cardio",
      exercises: [
        Exercise(
            name: "Running", weight: "No Weight", reps: "10 min", sets: "3"),
        Exercise(
            name: "Skipping Ropes",
            weight: "No Weight",
            reps: "10 min",
            sets: "3")
      ],
    ),
  ];

  void initializeWorkoutList() {
    if (db.previousDataExists()) {
      workoutList = db.readFromDatabase();
    } else {
      db.saveToDatabase(workoutList);
    }
    loadHeatMap();
  }

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  int numberOfExercisesInWorkout(String workoutName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    return relevantWorkout.exercises.length;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    relevantWorkout.exercises.add(
        Exercise(name: exerciseName, weight: weight, reps: reps, sets: sets));
    notifyListeners();
    db.saveToDatabase(workoutList);
  }

  void checkOffExercise(String workoutName, String exerciseName) {
    Exercise relevantExercise = getRelevantExercise(workoutName, exerciseName);
    relevantExercise.isCompleted = !relevantExercise.isCompleted;
    notifyListeners();
    db.saveToDatabase(workoutList);
    loadHeatMap();
  }

  Workout getRelevantWorkout(String workoutName) {
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);
    return relevantWorkout;
  }

  Exercise getRelevantExercise(String workoutName, String exerciseName) {
    Workout relevantWorkout = getRelevantWorkout(workoutName);
    Exercise relevantExercise = relevantWorkout.exercises
        .firstWhere((exercise) => exercise.name == exerciseName);
    return relevantExercise;
  }

  String getStartDate() {
    return db.getStartDate();
  }

  Map<DateTime, int> heatMapDataSet = {};
  void loadHeatMap() {
    DateTime startDate = createDateTimeObject(getStartDate());
    int daysInBetween = DateTime.now().difference(startDate).inDays;

    for (int i = 0; i < daysInBetween + 1; i++) {
      String yyyymmdd =
          convertDateTimeToYYYYMMDD(startDate.add(Duration(days: i)));
      int completionStatus = db.getCompletionStatus(yyyymmdd);

      int year = startDate.add(Duration(days: i)).year;
      int month = startDate.add(Duration(days: i)).month;
      int day = startDate.add(Duration(days: i)).day;

      final percentForEachDay = <DateTime, int>{
        DateTime(year, month, day): completionStatus
      };

      heatMapDataSet.addEntries(percentForEachDay.entries);
    }
  }
}
