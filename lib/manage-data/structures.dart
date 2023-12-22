class Exercise {
  String? name;
  String? weight;
  String? reps;
  String? type;

  Exercise({this.name, this.weight, this.reps, this.type});

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      name: json['name'] as String?,
      weight: json['weight'] as String?,
      reps: json['reps'] as String?,
      type: json['type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'weight': weight,
      'reps': reps,
      'type': type,
    };
  }
}

class Workout {
  String name;
  List<Exercise> exercises;

  Workout({required this.name, required this.exercises});

  factory Workout.fromJson(Map<String, dynamic> json) {
    var exercisesJson = json['exercises'] as List<dynamic>?;
    var exercises = exercisesJson?.map((e) => Exercise.fromJson(e)).toList();

    return Workout(
      name: json['name'] as String,
      exercises: exercises ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
    };
  }
}

class Gym {
  String name;
  List<Workout> workouts;

  Gym({required this.name, required this.workouts});

  factory Gym.fromJson(Map<String, dynamic> json) {
    var workoutsJson = json['workouts'] as List<dynamic>?;
    var workouts = workoutsJson?.map((e) => Workout.fromJson(e)).toList();

    return Gym(
      name: json['name'] as String,
      workouts: workouts ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'workouts': workouts.map((e) => e.toJson()).toList(),
    };
  }
}