import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'screens/home_page.dart';
import 'screens/gacha.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

  /*
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
      initialRoute: '/gacha',
      routes: {
        '/gacha': (context) => GachaScreen(),
      },
    );
  }
}
