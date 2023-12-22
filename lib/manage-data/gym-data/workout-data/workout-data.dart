import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/structures.dart';

// Define the StatefulWidget
class WorkoutDataWidget extends StatefulWidget {
  final Function(Workout) onUpdate;
  final Function(Workout) deleteWorkout;
  Workout workoutData;
  WorkoutDataWidget({Key? key, required this.workoutData, required this.onUpdate, required this.deleteWorkout}) : super(key: key);

  @override
  _WorkoutDataWidgetState createState() => _WorkoutDataWidgetState();
}

class _WorkoutDataWidgetState extends State<WorkoutDataWidget> {
  void _addNewExercise() {
    setState(() {
      widget.workoutData.exercises.add(Exercise());
      widget.onUpdate(widget.workoutData);
    });
  }

  void _removeExercise(Exercise toRemove) {
    setState(() {
      widget.workoutData.exercises.remove(toRemove);
      widget.onUpdate(widget.workoutData);
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child:  DataTable(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 1.0, color: Colors.black),
                  bottom: BorderSide(width: 1.0, color: Colors.black),
                ),
              ),
              columns: const <DataColumn>[
                DataColumn(label: Text('')),
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Weight')),
                DataColumn(label: Text('Reps')),
                DataColumn(label: Text('Type')),
              ],
              rows: widget.workoutData.exercises.map((exercise) => DataRow(cells: [
                DataCell(
                  IconButton(
                    color: Colors.red,
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      _removeExercise(exercise);
                    },
                  )
                ),

                DataCell(
                  TextFormField(
                    initialValue: exercise.name,
                    onChanged: (value) => setState(() {exercise.name = value; widget.onUpdate(widget.workoutData);}),
                  )
                ),
                DataCell(
                  TextFormField(
                    initialValue: exercise.weight,
                    onChanged: (value) => setState(() {exercise.weight = value; widget.onUpdate(widget.workoutData);}),
                  )
                ),
                DataCell(
                  TextFormField(
                    initialValue: exercise.reps,
                    onChanged: (value) => setState(() {exercise.reps = value; widget.onUpdate(widget.workoutData);}),
                  )
                ),
                DataCell(
                  DropdownButtonFormField<String>(
                    value: exercise.type,
                    onChanged: (newValue) => setState(() {exercise.type = newValue; widget.onUpdate(widget.workoutData);}),
                    items: <String>['Hypo', 'Strength', 'Endurance']
                        .map<DropdownMenuItem<String>>((String value) {
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
                  )
                ),
              ])).toList(),
            ),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _addNewExercise,
                  child: const Text('Add Exercise'),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}