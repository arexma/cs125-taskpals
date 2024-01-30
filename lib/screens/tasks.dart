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
  int _currentIndex = 0;
  int _onPressedTracker = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 350,
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
            const Text("Daily Tasks"),
            ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              children: <Widget>[
                Container(
                  height: 70,
                  color: Colors.amber[600],
                  child: const Center(child: Text('Entry A')),
                ),
                Container(
                  height: 70,
                  color: Colors.amber[500],
                  child: const Center(child: Text('Entry B')),
                ),
                Container(
                  height: 70,
                  color: Colors.amber[100],
                  child: const Center(child: Text('Entry C')),
                ),
                Container(
                  height: 70,
                  color: Colors.amber[50],
                  child: const Center(child: Text('Entry C')),
                ),
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {
                    _onPressedTracker += 1;
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlueAccent,
                    elevation: 2,
                  ),
                  child: const Text("Add new task."),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildStackElement(int index) {
    return Center(
      child: Text(
        "Current index: $index",
      ),
    );
  }
}
