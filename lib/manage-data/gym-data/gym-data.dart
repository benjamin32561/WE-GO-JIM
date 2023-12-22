import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/gym-data/exercise-table.dart';

class ExerciseContentWidget extends StatefulWidget {
  final String tabTitle;

  const ExerciseContentWidget({super.key, required this.tabTitle});

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

