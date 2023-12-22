import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/gym-data/gym-data.dart';
import 'package:we_go_jim/manage-data/structures.dart';

class GymDataWidget extends StatefulWidget {
  final Function(List<GymData>) onUpdate;
  List<GymData> gymsData = [];
  GymDataWidget({Key? key, required this.gymsData, required this.onUpdate}) : super(key: key);

  @override
  _GymDataWidgetState createState() => _GymDataWidgetState();
}

class _GymDataWidgetState extends State<GymDataWidget> {
  void _addNewTab() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Enter Gym Name'),
        content: TextField(
          onSubmitted: (String value) {
            Navigator.of(context).pop(value);
          },
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
        ],
      ),
    ).then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          GymData gymsDataToAdd = GymData(name: value, exercises: []);
          widget.gymsData.add(gymsDataToAdd);
          widget.onUpdate(widget.gymsData);
        });
      }
    });
  }

  void _deleteTab() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return DeleteTabDialog(
          tabTitles: widget.gymsData.map((gymsData) => gymsData.name!).toList(),
          onDelete: (String value) {
            setState(() {
              widget.gymsData.removeWhere((gymsData) => gymsData.name == value);
              widget.onUpdate(widget.gymsData);
            });
          },
        );
      },
    );
  }

  updateGymData(GymData gymData) {
    setState(() {
      widget.gymsData[widget.gymsData.indexWhere((element) => element.name == gymData.name)] = gymData;
      widget.onUpdate(widget.gymsData);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.gymsData.length,
      child: Column(
        children: [
          // TabBar which allows selecting between different tabTitles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.remove),
                onPressed: () {
                  // Implement the logic to add a new tab
                  _deleteTab();
                },
              ),
              Expanded(
                child: TabBar(
                  isScrollable: true,
                  tabs: widget.gymsData
                      .map((gymsData) => Tab(text: gymsData.name))
                      .toList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  _addNewTab();
                },
              ),
            ],
          ),
          Expanded(
            child: TabBarView(
              children: widget.gymsData
                  .map((gymData) => ExerciseContentWidget(
                        gymData: gymData,
                        onUpdate: (GymData gymData) {
                          setState(() {});
                        },
                    )
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class DeleteTabDialog extends StatefulWidget {
  final List<String> tabTitles;
  final Function(String) onDelete;

  const DeleteTabDialog({Key? key, required this.tabTitles, required this.onDelete}) : super(key: key);

  @override
  _DeleteTabDialogState createState() => _DeleteTabDialogState();
}

class _DeleteTabDialogState extends State<DeleteTabDialog> {
  String? selectedTab;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select a Gym to Delete'),
      content: DropdownButton<String>(
        value: selectedTab,
        isExpanded: true,
        onChanged: (String? newValue) {
          setState(() {
            selectedTab = newValue;
          });
        },
        items: widget.tabTitles.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            if (selectedTab != null) {
              widget.onDelete(selectedTab!);
              Navigator.of(context).pop();
            }
          },
          child: const Text('Delete'),
        ),
      ],
    );
  }
}
