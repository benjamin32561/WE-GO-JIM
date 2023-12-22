import 'dart:math';

import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/structures.dart';

// a simple statefull widget named "GenerateWorkoutWidget"
class GenerateWorkoutWidget extends StatefulWidget {
  final Function(List<Gym>) onUpdate;
  List<Gym> gymsData = [];
  GenerateWorkoutWidget({super.key, required this.gymsData, required this.onUpdate});

  @override
  _GenerateWorkoutWidgetState createState() => _GenerateWorkoutWidgetState();
}

// the state of the widget
class _GenerateWorkoutWidgetState extends State<GenerateWorkoutWidget>{
  final random = Random();

  List<Exercise> workoutLayout = [];
  Gym? selectedGym;
  Workout? selectedWorkout;

  void _generateWorkout() {
    // count number of strength exercises in seleted workout
    final nStrengthExercisesInWorkout = selectedWorkout!.exercises.where((exercise) => exercise.type == 'Strength').length;
    final nStrength = random.nextInt(max(nStrengthExercisesInWorkout,3)) + 1;
    // count number of hypo exercises in seleted workout
    final nHypoExercises = selectedWorkout!.exercises.where((exercise) => exercise.type == 'Hypo').length;
    int nHypo = 0;
    if (nStrength == 0) {
      nHypo = random.nextInt(max(nHypoExercises,3)) + 4; // Range 4-6
    } else if (nStrength == 1) {
      nHypo = random.nextInt(max(nHypoExercises,3)) + 3; // Range 3-5
    } else if (nStrength == 2) {
      nHypo = random.nextInt(max(nHypoExercises,2)) + 2; // Range 2-3
    } else {
      nHypo = random.nextInt(max(nHypoExercises,2)) + 1; // Range 1-2
    }

    List<Exercise> strengthExercises = selectRandomElements(selectedWorkout!.exercises.where((exercise) => exercise.type == 'Strength').toList(), nStrength);
    List<Exercise> hypoExercises = selectRandomElements(selectedWorkout!.exercises.where((exercise) => exercise.type == 'Hypo').toList(), nHypo);

    workoutLayout = [...strengthExercises, ...hypoExercises];

    setState(() {});
  }

  List<T> selectRandomElements<T>(List<T> list, int n) {
    var random = Random();
    int length = list.length;

    for (int i = length - 1; i > 0; i--) {
      int randomIndex = random.nextInt(i + 1);

      // Swapping elements
      T temp = list[i];
      list[i] = list[randomIndex];
      list[randomIndex] = temp;
    }

    return list.sublist(0, n);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('GYM: '),
              //dropdown for selecting gym
              DropdownButton<Gym>(
                value: selectedGym,
                onChanged: (Gym? newValue) {
                  setState(() {
                    selectedGym = newValue;
                  });
                },
                items: widget.gymsData.map((Gym gym) {
                  return DropdownMenuItem<Gym>(
                    value: gym,
                    child: Text(gym.name),
                  );
                }).toList(),
              ),
              //dropdown for selecting workout type
              const Text('Workout Type: '),
              DropdownButton<Workout>(
                value: selectedWorkout,
                onChanged: (Workout? newValue) {
                  setState(() {
                    selectedWorkout = newValue!;
                  });
                },
                items: widget.gymsData[0].workouts.map((Workout workout) {
                  return DropdownMenuItem<Workout>(
                    value: workout,
                    child: Text(workout.name),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          //list of exercises in workout
          
          ElevatedButton(
            onPressed: () => _generateWorkout(),
            child: const Text('Generate Workout'),
          ),
        ],
      ),
    );
  }
}