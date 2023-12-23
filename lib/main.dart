import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:we_go_jim/generate-workout/generate-workout.dart';
import 'package:we_go_jim/manage-data/gyms.dart';
import 'dart:convert';
import 'package:we_go_jim/structures.dart';

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

class GymApp extends StatefulWidget {
  const GymApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GymAppState createState() => _GymAppState();
}

class _GymAppState extends State<GymApp> {
  List<Gym> gymsData = [];

  @override
  void initState() {
    super.initState();
    _loadGym();
  }

  void updateAndSaveGym(List<Gym> updatedData) {
    setState(() { gymsData = updatedData; });
    _saveGym();
  }

  Future<void> _loadGym() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('data');
    if (jsonString == null) {
      gymsData = [];
      return;
    }
    final List<dynamic> jsonData = json.decode(jsonString);
    gymsData = jsonData.map((jsonItem) => Gym.fromJson(jsonItem)).toList();
    setState(() {}); // Update the state once the data is loaded
  }

  Future<void> _saveGym() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final jsonString = json.encode(gymsData.map((gd) => gd.toJson()).toList());
    prefs.setString('data', jsonString);
    setState(() {}); // Update the state once the data is loaded
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text('WE GO JIM'),
              ElevatedButton(
                onPressed: _saveGym,
                child: const Text('Save'),
              ),
            ],
          
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'GYM Data'),
              Tab(text: 'Generate Workout'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GymsDataWidget(
              gymsData: gymsData,
              onUpdate: updateAndSaveGym,
            ),
            GenerateWorkoutWidget(
              gymsData: gymsData,
              onUpdate: updateAndSaveGym,
            ),
          ],
        ),
      ),
    );
  }
}