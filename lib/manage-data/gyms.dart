import 'package:flutter/material.dart';
import 'package:we_go_jim/manage-data/gym-data/gym-data.dart';

class SimpleSelectionBarWidget extends StatefulWidget {
  SimpleSelectionBarWidget({super.key});

  @override
  _SimpleSelectionBarWidgetState createState() => _SimpleSelectionBarWidgetState();
}

class _SimpleSelectionBarWidgetState extends State<SimpleSelectionBarWidget> {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WE GO JIM'),
          bottom: TabBar(
            isScrollable: true, // For scrolling if tabs overflow
            tabs: tabTitles.map((title) => Tab(text: title)).toList(),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: _addNewTab,
            ),
          ],
        ),
        body: TabBarView(
          children: tabTitles
              .map((title) => ExerciseContentWidget(tabTitle: title))
              .toList(),
        ),
      ),
    );
  }
}