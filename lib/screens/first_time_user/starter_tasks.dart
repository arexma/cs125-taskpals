import 'package:flutter/material.dart';

import 'navigation.dart';
import '../../utility/editable_field.dart';

class StarterTasks extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  final List<String> savedTasks;

  const StarterTasks({
    super.key,
    required this.navigationWidget,
    required this.updateData,
    required this.savedTasks,
  });

  @override
  State<StarterTasks> createState() => _StarterTasks();
}

class _StarterTasks extends State<StarterTasks> {
  List<String> tasks = [];
  late EditableTextField textField;

  final GlobalKey<EditableTextFieldState> _editableTextFieldKey =
      GlobalKey<EditableTextFieldState>();

  @override
  void initState() {
    super.initState();
    textField = EditableTextField(
      key: _editableTextFieldKey,
      boxWidth: 300,
      boxHeight: 40,
      borderColor: Colors.black,
      borderWidth: 2,
      borderRadius: 10,
      edgeInsets: 5,
      textAlignment: Alignment.centerLeft,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 100.0),
          const Text(
            'Starter Tasks',
            style: TextStyle(
              color: Colors.black,
              fontSize: 45.0,
            ),
          ),
          Text(
            '${tasks.length} / 5',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 35.0,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      border: Border.all(
                        color: Colors.grey[400]!,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Dismissible(
                      key: Key(tasks[index]),
                      onDismissed: (direction) {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: ListTile(
                        title: Text(tasks[index]),
                        onTap: () {}, // task editing
                      ),
                    ),
                  );
                  /*
                  return Dismissible(
                    key: Key(tasks[index]),
                    onDismissed: (direction) {
                      try {
                        setState(() {
                          tasks.removeAt(index);
                        });
                      } catch (e) {
                        print('Error $e');
                      }
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          child: ListTile(
                            title: Text(tasks[index]),
                            onTap: () {}, // task editing
                          ),
                        ),
                        if (index < tasks.length - 1)
                          const Divider(
                            height: 0,
                            color: Colors.grey,
                          ),
                      ],
                    ),
                  );
                  */
                },
              ),
            ),
          ),
          const SizedBox(height: 100.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textField,
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: tasks.length == 5
                    ? null
                    : () {
                        EditableTextFieldState? currentState =
                            _editableTextFieldKey.currentState;
                        String currentTask = currentState!.getCurrentText();
                        if (currentTask.isNotEmpty) {
                          currentState.resetText();
                          setState(
                            () {
                              tasks.add(currentTask);
                            },
                          );
                        }
                      },
              ),
            ],
          ), // Row for user to type task and click plus button to add to tasks
          const Spacer(),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
