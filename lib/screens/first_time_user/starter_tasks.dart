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

  final GlobalKey<EditableTextFieldState> _editableTextFieldKey =
      GlobalKey<EditableTextFieldState>();

  @override
  void initState() {
    super.initState();
    tasks = widget.savedTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/screen_backgrounds/first_time_user.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const Spacer(),
              const Text(
                'Starter Tasks',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.0,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                '${tasks.length} / 5',
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.4,
                padding: const EdgeInsets.all(10.0),
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
                          decoration: BoxDecoration(
                            color: Colors.red,
                            border: Border.all(
                              color: Colors.red[600]!,
                            ),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                        ),
                        child: ListTile(
                          title: Text(tasks[index]),
                          onTap: () {}, // task editing
                        ),
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  EditableTextField(
                    key: _editableTextFieldKey,
                    boxWidth: MediaQuery.of(context).size.width * 0.8 - 48.0,
                    boxHeight: MediaQuery.of(context).size.height * 0.1 - 48.0,
                    borderColor: Colors.black,
                    borderWidth: 2,
                    borderRadius: 10,
                    edgeInsets: 5,
                    textAlignment: Alignment.centerLeft,
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.black,
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
                              widget.updateData('tasks', tasks);
                            }
                          },
                  ),
                ],
              ),
              const Spacer(),
              widget.navigationWidget,
            ],
          ),
        ],
      ),
    );
  }
}
