import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/gym-data/gym-data.dart';

class GymDataWidget extends StatefulWidget {
  const GymDataWidget({super.key});

  @override
  _GymDataWidgetState createState() => _GymDataWidgetState();
}

class _GymDataWidgetState extends State<GymDataWidget> {
  List<String> tabTitles = ['GYM 1', 'GYM 2', 'GYM 3'];

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
          tabTitles.add(value);
        });
      }
    });
  }

  void _deleteTab(String title) {
    setState(() {
      tabTitles.remove(title);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Column(
        children: [
          AppBar(
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: TabBar(
                      isScrollable: true,
                      tabs: tabTitles.map((title) {
                        return Tab(
                          child: Row(
                            children: [
                              Text(title),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 18),
                                onPressed: () => _deleteTab(title),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _addNewTab,
                  ),
                ],
              ),
            ),
            title: null,
          ),
          Expanded(
            child: TabBarView(
              children: tabTitles
                  .map((title) => ExerciseContentWidget(tabTitle: title))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}