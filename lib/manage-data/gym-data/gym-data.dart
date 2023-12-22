import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/gym-data/workout-data/workout-data.dart';
import 'package:we_go_jim/manage-data/structures.dart';

class GymDataWidget extends StatefulWidget {
  final Function(Gym) onUpdate;
  Gym gymData;
  GymDataWidget({Key? key, required this.gymData, required this.onUpdate}) : super(key: key);

  @override
  _GymDataWidgetState createState() => _GymDataWidgetState();
}

class _GymDataWidgetState extends State<GymDataWidget> {
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // add workout
        
        children: widget.gymData.workouts.map((workout) {
          return WorkoutDataWidget(
            workoutData: workout,
            onUpdate: (updatedWorkout) {
              setState(() {
                widget.gymData.workouts[widget.gymData.workouts.indexOf(workout)] = updatedWorkout;
                widget.onUpdate(widget.gymData);
              });
            },
          );
        }).toList(),
      ),
    );
  }
}

