/*
View of daily tasks to complete
*/

// TODO: make new recommended tasks stay on the screen after reload (new way to see rec)
import 'dart:convert';

import 'package:flutter/material.dart';
import '../services/user_data.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class TasksPageStarter extends StatefulWidget {
  final UserDataFirebase user;
  const TasksPageStarter({super.key, required this.user});

  @override
  State<TasksPageStarter> createState() => TasksPage();
}

class TasksPage extends State<TasksPageStarter> {
  // final PageController _pageController = PageController(initialPage: 0);
  final ScrollController _scrollController = ScrollController();
  // final ScrollController _completedTasksListController = ScrollController();
  // final ScrollController _deletedTasksListController = ScrollController();
  List<Widget> tasksList = [];
  List<String> tasksCompletedList = [];
  List<String> tasksDeletedList = [];
  List<String> recommendedTasksList = [];
  int _currentIndex = 0;
  int _listItemKey = 0;
  //var env = DotEnv(includePlatformEnvironment: true)..load();

  @override
  void initState() {
    super.initState();
    List<dynamic> tasks = queryToStringsList('tasks');
    queryToTasksList(tasks);
    List<dynamic> completedTasks = queryToStringsList('completed_tasks');
    List<dynamic> deletedTasks = queryToStringsList('deleted_tasks');
    queryToTopLists(completedTasks, deletedTasks);
    addRecommendedTasks();
  }

  Future<String> sendMessage(String message) async {
    print(dotenv.env['OPENAIKEY']);
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${dotenv.env['OPENAIKEY']}',
      },
      body: json.encode({
        'model': 'gpt-3.5-turbo',
        'messages': [
          {
            'role': 'user',
            'content': message,
          }
        ],
        'max_tokens': 200,
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['choices'][0]['message']['content']);
      return jsonResponse['choices'][0]['message']['content'].toString();
    } else {
      print("Resquest failed with status: ${response.statusCode}");
      print("Error message: ${response.body}");
    }
    return 'Failed to obtain response';
  }

  // obtains tasks from database and turns into list (string)
  List<dynamic> queryToStringsList(String field) {
    Map<String, dynamic> query = widget.user.queryByUniqueID([field]);
    return query[field] ?? [];
  }

  // takes list of strings (from query) and turns into task list (widgets)
  void queryToTasksList(List<dynamic> queryList) {
    for (int i = 0; i < queryList.length; i++) {
      tasksList
          .add(buildListElement(_listItemKey, tasksList.length, queryList[i]));
      _listItemKey += 1;
    }
  }

  void queryToTopLists(
      List<dynamic> queryCompleted, List<dynamic> queryDeleted) {
    for (int i = 0; i < queryCompleted.length; i++) {
      tasksCompletedList.add(queryCompleted[i]);
    }
    for (int i = 0; i < queryDeleted.length; i++) {
      tasksDeletedList.add(queryDeleted[i]);
    }
  }

  void addRecommendedTasks() async {
    List<dynamic> goals = queryToStringsList('goals');
    String goalsListString = goals.toString();
    String tasksCompletedListString = tasksCompletedList.toString();
    String tasksDeletedListString = tasksDeletedList.toString();
    String prompt =
        "can you give me 1 task to complete if i want to improve my diet? keep it short and simple like Sleep 8 hours. "
        "or like Wake up at 6 am. I want it to be a task rather than a recommendation. "
        "i dont want the words every day to be on the prompt as it will be a task to complete in a day anyway. "
        "the following list will be a list of goals in string format to help create some tasks. "
        "these are some starter goals the user wants to improve on but you do not have to adhere to only these goals: $goalsListString "
        "the following is a list of tasks they have completed: $tasksCompletedListString "
        "the following is a  list of tasks they have deleted: $tasksDeletedListString "
        "i want you to return 5 to 10 tasks in the format of comma separated values in code like 'task1','task2','task3'";

    String response = await sendMessage(prompt);
    response = response.substring(1, response.length - 1);
    List<String> temp = response.split(RegExp(r"', *'"));
    recommendedTasksList.addAll(temp);

    setState(() {});
  }

  addListItem(String taskDescription, {bool initialize = false}) {
    setState(() {
      tasksList.add(
          buildListElement(_listItemKey, tasksList.length, taskDescription));
      _listItemKey += 1;
      List<dynamic> tasks = widget.user.queryByUniqueID(['tasks'])['tasks'];
      tasks.add(taskDescription);
      widget.user.updateDatabase({'tasks': tasks});
    });

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
      );
    }
  }

  deleteListItem(Key key, String taskDescription, {bool addPoints = false}) {
    setState(() {
      tasksList.removeWhere((item) => item.key == key);
      if (addPoints) {
        tasksCompletedList.add(taskDescription);
        Map<String, dynamic> tasks =
            widget.user.queryByUniqueID(['completed_tasks', 'tasks']);
        if (tasks['completed_tasks'] == null) {
          tasks['completed_tasks'] = [taskDescription];
        } else {
          tasks['completed_tasks'].add(taskDescription);
        }
        tasks['tasks'].remove(taskDescription);
        widget.user.updateDatabase(tasks);
      } else {
        tasksDeletedList.add(taskDescription);
        Map<String, dynamic> tasks =
            widget.user.queryByUniqueID(['deleted_tasks', 'tasks']);
        if (tasks['deleted_tasks'] == null) {
          tasks['deleted_tasks'] = [taskDescription];
        } else {
          tasks['deleted_tasks'].add(taskDescription);
        }
        tasks['tasks'].remove(taskDescription);
        widget.user.updateDatabase(tasks);
      }
    });
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: PageView.builder(
                  // controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return recommendedTasksViewer(recommendedTasksList);
                    } else if (index == 1) {
                      return tasksCompletedViewer(tasksCompletedList);
                    } else {
                      return tasksDeletedViewer(tasksDeletedList);
                    }
                  },
                  itemCount: 3,
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  color: ThemeProvider.themeOf(context).data.dividerColor,
                  child: const Center(
                    child: Text("Daily Tasks"),
                  ),
                ),
              ),
              Expanded(
                flex: 8,
                child: tasksList.isEmpty
                    ? const Center(
                        child: Text(
                          "ADD SOME TASKS",
                          style: TextStyle(fontSize: 40),
                        ),
                      )
                    : ListView.builder(
                        controller: _scrollController,
                        // reverse: true,
                        itemCount: tasksList.length,
                        itemBuilder: (context, index) => tasksList[index],
                      ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {
                        _showAddTaskDialog(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeProvider.themeOf(context)
                            .data
                            .dialogBackgroundColor,
                        elevation: 10,
                      ),
                      child: Text(
                        "Add new task.",
                        style: TextStyle(
                          color: ThemeProvider.themeOf(context)
                              .data
                              .unselectedWidgetColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget recommendedTasksViewer(List<String> recommendedTasksList) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.blue,
            child: const Center(
              child: Text("Recommended Tasks"),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: recommendedTasksList.length,
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              height: 70,
              child: Center(
                child: Text(recommendedTasksList[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tasksCompletedViewer(List<String> tasksCompletedList) {
    int tasksCompleted = tasksCompletedList.length;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.green,
            child: Center(
              child: Text("Tasks Completed: $tasksCompleted"),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: tasksCompletedList.length,
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(
                color: Colors.lightGreenAccent,
              ),
              height: 70,
              child: Center(
                child: Text(tasksCompletedList[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tasksDeletedViewer(List<String> tasksDeletedList) {
    int tasksDeleted = tasksDeletedList.length;
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.red,
            child: Center(
              child: Text("Tasks Deleted: $tasksDeleted"),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: ListView.builder(
            itemCount: tasksDeletedList.length,
            itemBuilder: (context, index) => Container(
              decoration: const BoxDecoration(
                color: Colors.redAccent,
              ),
              height: 70,
              child: Center(
                child: Text(tasksDeletedList[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildListElement(int listItemKey, int index, String taskDescription) {
    return Dismissible(
      key: Key(listItemKey.toString()),
      direction: DismissDirection.horizontal,
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          deleteListItem(Key(listItemKey.toString()), taskDescription);
        } else if (direction == DismissDirection.endToStart) {
          deleteListItem(Key(listItemKey.toString()), taskDescription,
              addPoints: true);
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      secondaryBackground: Container(
        color: Colors.green,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.fact_check_rounded,
          color: Colors.white,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.lightGreenAccent,
          border: Border.all(
            color: Colors.lightGreen,
          ),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        height: 70,
        child: Center(
          child: Text(
            taskDescription,
          ),
        ),
      ),
    );
  }

  Future<void> _showAddTaskDialog(BuildContext context) async {
    TextEditingController textEditingController = TextEditingController();

    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add new task.'),
            content: TextField(
              controller: textEditingController,
              // onChanged: (value) {},
              decoration: const InputDecoration(
                  hintText: 'Enter task you want to accomplish.'),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  String description = textEditingController.text;
                  if (description.isNotEmpty) {
                    addListItem(description);
                    Navigator.of(context).pop(description);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          );
        });
  }
}
