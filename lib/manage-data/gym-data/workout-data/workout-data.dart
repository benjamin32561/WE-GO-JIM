import 'package:flutter/material.dart';
import 'package:we_go_jim/structures.dart';

// ignore: must_be_immutable
class WorkoutDataWidget extends StatefulWidget {
  final Function(Workout) onUpdate;
  final Function(Workout) deleteWorkout;
  Workout workoutData;
  WorkoutDataWidget({super.key, required this.workoutData, required this.onUpdate, required this.deleteWorkout});

  @override
  // ignore: library_private_types_in_public_api
  _WorkoutDataWidgetState createState() => _WorkoutDataWidgetState();
}

class _WorkoutDataWidgetState extends State<WorkoutDataWidget> {
  void _addNewExercise() {
    setState(() {
      widget.workoutData.exercises.add(Exercise());
      widget.onUpdate(widget.workoutData);
    });
  }

  void _removeExercise(String toRemoveId) {
    setState(() {
      widget.workoutData.exercises.removeWhere((exercise) => exercise.id == toRemoveId);
      widget.onUpdate(widget.workoutData);
    });
  }

  List<ListTile> _buildExerciseTiles() {
    return widget.workoutData.exercises.map((exercise) {
      return ListTile(
        key: ValueKey(exercise.id),
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => _removeExercise(exercise.id),
              ),
              const SizedBox(width: 10,),
              Container(
                width: 100, // Adjust the width as needed
                child: TextFormField(
                  initialValue: exercise.name,
                  onChanged: (value) => setState(() {
                    exercise.name = value;
                    widget.onUpdate(widget.workoutData);
                  }),
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                width: 80, // Adjust the width as needed
                child: TextFormField(
                  initialValue: exercise.weight,
                  onChanged: (value) => setState(() {
                    exercise.weight = value;
                    widget.onUpdate(widget.workoutData);
                  }),
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                width: 80, // Adjust the width as needed
                child: TextFormField(
                  initialValue: exercise.reps,
                  onChanged: (value) => setState(() {
                    exercise.reps = value;
                    widget.onUpdate(widget.workoutData);
                  }),
                ),
              ),
              const SizedBox(width: 10,),
              Container(
                width: 120, // Adjust the width as needed
                child: DropdownButtonFormField<String>(
                  value: exercise.type,
                  onChanged: (newValue) => setState(() {
                    exercise.type = newValue;
                    widget.onUpdate(widget.workoutData);
                  }),
                  items: ExerciseTypes.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
                    border: OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              // icon of menu
              IconButton(
                icon: const Icon(Icons.menu), 
                onPressed: () {},
              )
            ],
          ),
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //Icon button for deleting current workout
              IconButton(
                color: Colors.red,
                icon: const Icon(Icons.delete),
                onPressed: () {
                  widget.deleteWorkout(widget.workoutData);
                },
              ),
              Text(
                widget.workoutData.name,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, 
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ReorderableListView(
            shrinkWrap: true,
            // scrollDirection: Axis.horizontal,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = widget.workoutData.exercises.removeAt(oldIndex);
                widget.workoutData.exercises.insert(newIndex, item);
              });
            },
            children: _buildExerciseTiles(),
          ),
          ElevatedButton(
            onPressed: _addNewExercise,
            child: const Text('Add Exercise'),
          ),
        ],
      ),
    );
  }
}