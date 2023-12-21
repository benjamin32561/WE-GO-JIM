import 'package:flutter/material.dart';

class ExerciseContentWidget extends StatefulWidget {
  final String tabTitle;

  ExerciseContentWidget({required this.tabTitle});

  @override
  _ExerciseContentWidgetState createState() => _ExerciseContentWidgetState();
}

class _ExerciseContentWidgetState extends State<ExerciseContentWidget> {
  List<Exercise> exercises = [];

  void _addNewExercise() {
    setState(() {
      exercises.add(Exercise());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.tabTitle),
              ElevatedButton(
                onPressed: _addNewExercise,
                child: const Text('Add Exercise'),
              ),
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('Name')),
                DataColumn(label: Text('Weight')),
                DataColumn(label: Text('Reps')),
                DataColumn(label: Text('Type')),
              ],
              rows: exercises.map((exercise) => DataRow(cells: [
                    DataCell(TextFormField(
                      initialValue: exercise.name,
                      onChanged: (value) => setState(() => exercise.name = value),
                    )),
                    DataCell(TextFormField(
                      initialValue: exercise.weight,
                      onChanged: (value) => setState(() => exercise.weight = value),
                    )),
                    DataCell(TextFormField(
                      initialValue: exercise.reps,
                      onChanged: (value) => setState(() => exercise.reps = value),
                    )),
                    DataCell(DropdownButtonFormField<String>(
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
                    )),
                  ])).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class Exercise {
  String? name;
  String? weight;
  String? reps;
  String? type;

  Exercise({this.name = '', this.weight = '', this.reps = '', this.type});
}