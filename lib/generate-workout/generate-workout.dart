import 'dart:math';
import 'package:flutter/material.dart';
import 'package:we_go_jim/structures.dart';

// a simple statefull widget named "GenerateWorkoutWidget"
// ignore: must_be_immutable
class GenerateWorkoutWidget extends StatefulWidget {
  final Function(List<Gym>) onUpdate;
  List<Gym> gymsData = [];
  GenerateWorkoutWidget({super.key, required this.gymsData, required this.onUpdate});

  @override
  // ignore: library_private_types_in_public_api
  _GenerateWorkoutWidgetState createState() => _GenerateWorkoutWidgetState();
}

// the state of the widget
class _GenerateWorkoutWidgetState extends State<GenerateWorkoutWidget> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  final random = Random();

  List<String> workoutLayout = [];
  Gym? selectedGym;
  Workout? selectedWorkout;

  @override
  void initState() {
    super.initState();
    if (widget.gymsData.isNotEmpty) {
      selectedGym = widget.gymsData[0];
      if (selectedGym!.workouts.isNotEmpty){
        selectedWorkout = selectedGym!.workouts[0];
      }
    }
  }

  void _generateWorkout() {
    // count number of strength exercises in seleted workout
    final nStrengthExercisesInWorkout = selectedWorkout!.exercises.where((exercise) => exercise.type == 'Strength').length;
    int nStrength = random.nextInt(min(nStrengthExercisesInWorkout+1,4)); // 0<=x<=min(nStrengthExercisesInWorkout,3)
    print(nStrength);
    
    // count number of hypo exercises in seleted workout
    final nHypoExercises = selectedWorkout!.exercises.where((exercise) => exercise.type == 'Hypo').length;
    int nHypo = 0;
    if (nHypoExercises>0){
      if (nStrength == 0) {
        nHypo = min(random.nextInt(min(nHypoExercises,3)) + 4, nHypoExercises); // Range 4-6
      }
      else if (nStrength == 1) {
        nHypo = min(random.nextInt(min(nHypoExercises,3)) + 3, nHypoExercises); // Range 3-5
      }
      else if (nStrength == 2) {
        nHypo = min(random.nextInt(min(nHypoExercises,2)) + 2,nHypoExercises); // Range 2-3
      } 
      else {
        nHypo = min(random.nextInt(min(nHypoExercises,2)) + 1, nHypoExercises); // Range 1-2
      }
    }

    List<Exercise> strengthExercises = selectRandomElements(selectedWorkout!.exercises.where((exercise) => exercise.type == 'Strength').toList(), nStrength);
    List<Exercise> hypoExercises = selectRandomElements(selectedWorkout!.exercises.where((exercise) => exercise.type == 'Hypo').toList(), nHypo);

    // add exercises ids to workout layout
    workoutLayout = [];
    for (var exercise in strengthExercises) {
      workoutLayout.add(exercise.id);
    }
    for (var exercise in hypoExercises) {
      workoutLayout.add(exercise.id);
    }

    setState(() {});
  }

  List<T> selectRandomElements<T>(List<T> list, int n) {
    var random = Random();
    int length = list.length;

    for (int i = length - 1; i > 0; i--) {
      int randomIndex = random.nextInt(i + 1);

      // Swapping elements
      T temp = list[i];
      list[i] = list[randomIndex];
      list[randomIndex] = temp;
    }

    return list.sublist(0, n);
  }

  void _removeExerciseFromLayout(String exerciseId) {
    setState(() {
      workoutLayout.remove(exerciseId);
    });
  }

  void _addExerciseToLayout(String exerciseId) {
    setState(() {
      workoutLayout.add(exerciseId);
    });
  }

  void _addExerciseToWorkout(){
    // create exersice list to choose from
    List<Exercise> exerciseList = [];
    for (var exercise in selectedWorkout!.exercises) {
      if (!workoutLayout.contains(exercise.id)) {
        exerciseList.add(exercise);
      }
    }
    // open diaglog to select exercise
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Exercise'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                // list of exercises in workout
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child:  DataTable(
                    decoration: const BoxDecoration(
                      border: Border(
                        top: BorderSide(width: 1.0, color: Colors.black),
                        bottom: BorderSide(width: 1.0, color: Colors.black),
                      ),
                    ),
                    columns: const <DataColumn>[
                      DataColumn(label: Text('')),
                      DataColumn(label: Text('Name')),
                      DataColumn(label: Text('Weight')),
                      DataColumn(label: Text('Reps')),
                      DataColumn(label: Text('Type')),
                    ],
                    rows: exerciseList.map((exercise) => DataRow(cells: [
                      DataCell(
                        IconButton(
                          color: Colors.green,
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            _addExerciseToLayout(exercise.id);
                            Navigator.of(context).pop();
                          },
                        )
                      ),
                      DataCell(Text(exercise.name!)),
                      DataCell(Text(exercise.weight!)),
                      DataCell(Text(exercise.reps!)),
                      DataCell(Text(exercise.type!)),
                    ])).toList(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<ListTile> _buildExerciseListTiles() {
    return workoutLayout.asMap().entries.map((entry) {
      String exerciseId = entry.value;
      final exercise = selectedWorkout!.exercises.firstWhere((e) => e.id == exerciseId);

      return ListTile(
        key: ValueKey(exerciseId),
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _removeExerciseFromLayout(exerciseId),
            ),
            Expanded(
              flex: 2,
              child: Text(exercise.name!),
            ),
            Expanded(
              child: TextFormField(
                initialValue: exercise.weight,
                onChanged: (value) {
                  setState(() {
                    exercise.weight = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                initialValue: exercise.reps,
                onChanged: (value) {
                  setState(() {
                    exercise.reps = value;
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: Text(exercise.type!),
            ),
            IconButton(
              icon: const Icon(Icons.menu), 
              onPressed: () {},
            )
          ],
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text('GYM: '),
              //dropdown for selecting gym
              DropdownButton<Gym>(
                value: selectedGym,
                onChanged: (Gym? newValue) {
                  setState(() {
                    selectedGym = newValue;
                    selectedWorkout = selectedGym!.workouts[0];
                    workoutLayout = [];
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
              const Text('Workout Type: '),
              DropdownButton<Workout>(
                value: selectedWorkout,
                onChanged: (Workout? newValue) {
                  setState(() {
                    selectedWorkout = newValue!;
                    workoutLayout = [];
                  });
                },
                items: selectedGym!.workouts.map((Workout workout) {
                  return DropdownMenuItem<Workout>(
                    value: workout,
                    child: Text(workout.name),
                  );
                }).toList(),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ReorderableListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            onReorder: (int oldIndex, int newIndex) {
              setState(() {
                if (newIndex > oldIndex) {
                  newIndex -= 1;
                }
                final item = workoutLayout.removeAt(oldIndex);
                workoutLayout.insert(newIndex, item);
              });
            },
            children: _buildExerciseListTiles(),
          ),
          const SizedBox(height: 10),
          workoutLayout.isEmpty ?
            ElevatedButton(
              onPressed: () {
                _generateWorkout();
              },
              child: const Text('Generate Workout'),
            ):
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addExerciseToWorkout();
                  },
                  child: const Text('Add Exercises'),
                ),
                const SizedBox(width: 10,),
                IconButton(
                  icon: const Icon(Icons.refresh), 
                  onPressed: _generateWorkout,
                )
              ],
            )
        ],
      ),
    );
  }
}