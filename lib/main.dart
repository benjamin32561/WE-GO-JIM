import 'package:flutter/material.dart';
import 'package:we_go_jim/generate-workout/generate-workout.dart';
import 'package:we_go_jim/manage-data/gyms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WE GO JIM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.tealAccent[200]!),
        useMaterial3: true,
      ),
      home: const GymApp(),
    );
  }
}

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WE GO JIM'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'GYM Data'),
              Tab(text: 'Generate Workout'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            GymDataWidget(),
            GenerateWorkoutWidget(),
          ],
        ),
      ),
    );
  }
}