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
    return MaterialApp(
      title: 'Task Pals',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ), // Customize global color theming
        textTheme: const TextTheme(), // Customize global text theming
      ),
      initialRoute: '/profile',
      routes: {
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}
