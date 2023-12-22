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
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
              DropdownButton<String>(
                value: 'Strength',
                onChanged: (String? newValue) {
                  setState(() {
                    newValue = 'Strength';
                  });
                },
                items: <String>['Strength', 'Endurance', 'Cardio'].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}