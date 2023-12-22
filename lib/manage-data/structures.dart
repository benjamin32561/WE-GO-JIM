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
}

class GymData {
  String? name;
  List<Exercise>? exercises;

  GymData({this.name, this.exercises});

  factory GymData.fromJson(Map<String, dynamic> json) {
    var exercisesJson = json['exercises'] as List<dynamic>?;
    var exercises = exercisesJson?.map((e) => Exercise.fromJson(e)).toList();

    return GymData(
      name: json['name'] as String?,
      exercises: exercises,
    );
  }
}