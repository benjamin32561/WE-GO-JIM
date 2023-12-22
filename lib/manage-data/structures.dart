import 'package:uuid/uuid.dart';

var uuid = Uuid();

class Exercise {
  String id;
  String? name;
  String? weight;
  String? reps;
  String? type;

  Exercise({String? id, this.name, this.weight, this.reps, this.type})
      : id = id ?? uuid.v4();

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      weight: json['weight'] as String,
      reps: json['reps'] as String,
      type: json['type'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weight': weight,
      'reps': reps,
      'type': type,
    };
  }
}

class Workout {
  String id;
  String name;
  List<Exercise> exercises;

  Workout({String? id, required this.name, required this.exercises})
      : id = id ?? uuid.v4();

  factory Workout.fromJson(Map<String, dynamic> json) {
    var exercisesJson = json['exercises'] as List<dynamic>?;
    var exercises = exercisesJson?.map((e) => Exercise.fromJson(e)).toList();

    return Workout(
      id: json['id'] as String,
      name: json['name'] as String,
      exercises: exercises ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}

class Gym {
  String id;
  String name;
  List<Workout> workouts;

  Gym({String? id, required this.name, required this.workouts})
      : id = id ?? uuid.v4();

  factory Gym.fromJson(Map<String, dynamic> json) {
    var workoutsJson = json['workouts'] as List<dynamic>?;
    var workouts = workoutsJson?.map((e) => Workout.fromJson(e)).toList();

    return Gym(
      id: json['id'] as String,
      name: json['name'] as String,
      workouts: workouts ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'workouts': workouts.map((e) => e.toJson()).toList(),
    };
  }
}