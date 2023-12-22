import 'package:flutter/material.dart';

// a simple statefull widget named "GenerateWorkoutWidget"
class GenerateWorkoutWidget extends StatefulWidget {
  const GenerateWorkoutWidget({Key? key}) : super(key: key);

  @override
  _GenerateWorkoutWidgetState createState() => _GenerateWorkoutWidgetState();
}

// the state of the widget
class _GenerateWorkoutWidgetState extends State<GenerateWorkoutWidget>{
  @override
  Widget build(BuildContext context) {
    return Container();
    //select a gym using dropdown, also select workout type
    //randomly build workout
    //be able to edit order and excercises
  }
}