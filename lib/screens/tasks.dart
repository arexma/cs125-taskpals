/*
View of daily tasks to complete
*/
import 'package:flutter/material.dart';

class TasksPageStarter extends StatefulWidget {
  const TasksPageStarter({super.key});

  @override
  State<TasksPageStarter> createState() => TasksPage();
}

class TasksPage extends State<TasksPageStarter> {
  final PageController _pageController = PageController(initialPage: 0);
  final ScrollController _scrollController = ScrollController();
  List<Widget> tasksList = [];

  int _currentIndex = 0;
  int _listItemKey = 0;

  addListItem() {
    setState(() {
      tasksList.add(buildListElement(_listItemKey, tasksList.length));
      _listItemKey += 1;
    });

    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
    );
  }

  deleteListItem(Key key) {
    setState(() {
      tasksList.removeWhere((item) => item.key == key);
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
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 6,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  children: [
                    buildStackElement(_currentIndex),
                    buildStackElement(_currentIndex),
                    buildStackElement(_currentIndex),
                  ],
                ),
              ),
              const Expanded(
                flex: 1,
                child: Text("Daily Tasks"),
              ),
              Expanded(
                flex: 8,
                child: ListView.builder(
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
                      onPressed: addListItem,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        elevation: 2,
                      ),
                      child: const Text("Add new task."),
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

  Widget buildStackElement(int index) {
    return Container(
      color: Colors.lightBlueAccent,
      child: Center(
        child: Text(
          "Current index: $index",
        ),
      ),
    );
  }

  Widget buildListElement(int listItemKey, int index) {
    return Dismissible(
      key: Key(listItemKey.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          deleteListItem(Key(listItemKey.toString()));
        }
      },
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(
          Icons.delete,
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
            Radius.circular(20),
          ),
        ),
        height: 70,
        child: Center(
          child: Text(
            "Current index: $index",
          ),
        ),
      ),
    );
  }
}
