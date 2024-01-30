import 'package:flutter/material.dart';
import 'screens/profile_screen.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const TaskPals());
}

class TaskPals extends StatelessWidget {
  const TaskPals({Key? key}) : super(key: key);

  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Pals', initialRoute: '/login', routes: {
      '/login': (context) => const HomePage(),
    });
  }
  */

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Pals', initialRoute: '/profile', routes: {
      '/profile': (context) => const ProfileScreen(),
    });
  }
}
