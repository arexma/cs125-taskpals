import 'package:flutter/material.dart';
import 'screens/profile.dart';
import 'screens/home_page.dart';
import 'screens/tasks.dart';
import 'screens/gacha.dart';
import 'services/user_data.dart';
import 'screens/first_time_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const MaterialApp(
      home: TaskPals(),
    ),
  );
}

class TaskPals extends StatelessWidget {
  const TaskPals({Key? key}) : super(key: key);

  Future<String?> _getDeviceID(BuildContext context) async {
    var deviceInfo = DeviceInfoPlugin();
    if (Theme.of(context).platform == TargetPlatform.android) {
      const androidIdPlugin = AndroidId();
      return await androidIdPlugin.getId();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Pals', initialRoute: '/first', routes: {
      '/first': (context) => const FirstTimeUser(),
    });
  }

  /*
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Pals', initialRoute: '/tasks', routes: {
      '/tasks': (context) => const TasksPageStarter(),
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
      initialRoute: '/gacha',
      routes: {
        '/gacha': (context) => GachaScreen(),
      },
    );
  */
}
