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
  List<Exercise> workoutLayout = [];

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
                value: widget.gymsData[0],
                onChanged: (Gym? newValue) {
                  setState(() {
                    widget.gymsData[0] = newValue!;
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
                value: widget.gymsData[0].workouts[0],
                onChanged: (Workout? newValue) {
                  setState(() {
                    newValue = widget.gymsData[0].workouts[0];
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
          Column(
            children: workoutLayout.map((Exercise exercise) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(exercise.name!),
                  Text(exercise.reps!),
                  Text(exercise.weight!),
                ],
              );
            }).toList(),
          ),
          workoutLayout.isEmpty ? 
            ElevatedButton(
              onPressed: () {},
              child: const Text('Generate Workout Layout'),
            ) :
            ElevatedButton(
              onPressed: () {},
              child: const Text('Generate Workout'),
            ),
        ],
      ),
    );
  }
}