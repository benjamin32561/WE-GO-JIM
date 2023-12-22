import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/structures.dart';

// Define the StatefulWidget
class ExerciseTable extends StatefulWidget {
  final String tableName;

  const ExerciseTable({super.key, required this.tableName});

  @override
  _ExerciseTableState createState() => _ExerciseTableState();
}

class _ExerciseTableState extends State<ExerciseTable> {
  List<Exercise> exercises = [];

  void _addNewExercise() {
    setState(() {
      exercises.add(Exercise());
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
          Text(
            widget.tableName,
            style: const TextStyle(
                fontSize: 24, // Change this value to your desired size
                fontWeight: FontWeight.bold, // Makes the text bold
                // You can add more styling properties here if needed
            ),
          ),
          const SizedBox(height: 10),
          DataTable(
            columns: const <DataColumn>[
              DataColumn(label: Text('')),
              DataColumn(label: Text('Name')),
              DataColumn(label: Text('Weight')),
              DataColumn(label: Text('Reps')),
              DataColumn(label: Text('Type')),
            ],
            rows: exercises.map((exercise) => DataRow(cells: [
                  DataCell(
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          exercises.remove(exercise);
                        });
                      },
                    )
                  ),

                  DataCell(
                    TextFormField(
                      initialValue: exercise.name,
                      onChanged: (value) => setState(() => exercise.name = value),
                    )
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: exercise.weight,
                      onChanged: (value) => setState(() => exercise.weight = value),
                    )
                  ),
                  DataCell(
                    TextFormField(
                      initialValue: exercise.reps,
                      onChanged: (value) => setState(() => exercise.reps = value),
                    )
                  ),
                  DataCell(
                    DropdownButtonFormField<String>(
                      value: exercise.type,
                      onChanged: (newValue) => setState(() => exercise.type = newValue),
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