import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/gym-data/exercise-table.dart';
import 'package:we_go_jim/manage-data/structures.dart';

class ExerciseContentWidget extends StatefulWidget {
  final Function(GymData) onUpdate;
  GymData? gymData;
  ExerciseContentWidget({Key? key, required this.gymData, required this.onUpdate}) : super(key: key);

  @override
  _ExerciseContentWidgetState createState() => _ExerciseContentWidgetState();
}

class _ExerciseContentWidgetState extends State<ExerciseContentWidget> {
  

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          ExerciseTable(tableName: "Pull"),
          ExerciseTable(tableName: "Push"),
          ExerciseTable(tableName: "Legs")
        ],
      ),
    );
  }
}

