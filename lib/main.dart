import 'package:flutter/material.dart';
import 'loginPage.dart';

void main() {
  runApp(TaskPals());
}

class TaskPals extends StatelessWidget {
  const TaskPals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Pals',
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        }
      );
  }
}