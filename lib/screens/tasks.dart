/*
View of daily tasks to complete
*/
import 'package:flutter/material.dart';
import '../services/user_data.dart';
import 'package:theme_provider/theme_provider.dart';

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
  int tasksCompleted = 0;
  int tasksDeleted = 0;
  int _currentIndex = 0;
  int _listItemKey = 0;

  // obtains tasks from database and turns into list (string)
  List<String> queryToStringsList(String field) {
    Map<String, dynamic> query = queryByUniqueID([field]);

    return query[field];
  }

  // takes list of strings (from query) and turns into task list (widgets)
  void queryToTasksList(List<String> queryList) {
    for (int i = 0; i < queryList.length; i++) {
      addListItem(queryList[i]);
    }
  }

  void queryToTopLists(List<String> queryCompleted, List<String> queryDeleted) {
    for (int i = 0; i < queryCompleted.length; i++) {
      tasksCompletedList.add(queryCompleted[i]);
    }
    for (int i = 0; i < queryDeleted.length; i++) {
      tasksDeletedList.add(queryDeleted[i]);
    }
  }

  addListItem(String taskDescription) {
    setState(() {
      tasksList.add(
          buildListElement(_listItemKey, tasksList.length, taskDescription));
      updateDatabase(query['tasks'].append(taskDescription));
      _listItemKey += 1;
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
        tasksCompleted += 1;
        tasksCompletedList.add(taskDescription);
      } else {
        tasksDeleted += 1;
        tasksDeletedList.add(taskDescription);
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
                      return tasksCompletedViewer(
                          tasksCompleted, tasksCompletedList);
                    } else {
                      return tasksDeletedViewer(tasksDeleted, tasksDeletedList);
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

  Widget tasksCompletedViewer(
      int tasksCompleted, List<String> tasksCompletedList) {
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

  Widget tasksDeletedViewer(int tasksDeleted, List<String> tasksDeletedList) {
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
