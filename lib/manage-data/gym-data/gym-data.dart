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
  void _addWorkout(){
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Enter Workout Name'),
        content: TextField(
          onSubmitted: (String value) {
            Navigator.of(context).pop(value);
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          Workout workoutToAdd = Workout(name: value, exercises: []);
          widget.gymData.workouts.add(workoutToAdd);
          widget.onUpdate(widget.gymData);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ...widget.gymData.workouts.map((workout) {
            return WorkoutDataWidget(
              workoutData: workout,
              onUpdate: (updatedWorkout) {
                setState(() {
                  widget.gymData.workouts[widget.gymData.workouts.indexOf(workout)] = updatedWorkout;
                  widget.onUpdate(widget.gymData);
                });
              },
              deleteWorkout: (workoutToDelete) {
                 setState(() {
                  widget.gymData.workouts.remove(workoutToDelete);
                  widget.onUpdate(widget.gymData);
                });
              },
            );
          }),
          ElevatedButton(
            onPressed: _addWorkout,
            child: const Text('Create New Workout'),
          ),
        ],
      ),
    );
  }
}

