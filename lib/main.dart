import 'dart:io';

import 'package:flutter/material.dart';
import 'screens/gacha.dart';
import 'screens/home_page.dart';
import 'screens/first_time_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';
import 'services/user_data.dart';
/*

adding new user first time accessing app from unique device, 
profile page todos, 
gacha - alex
*/

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

class TaskPals extends StatefulWidget {
  const TaskPals({super.key});

  @override
  State<TaskPals> createState() => _TaskPals();
}

class _TaskPals extends State<TaskPals> {
  // Probably want to have global state management for database
  // connection, deviceID, and maybe isFirstTimeUser (?)
  late bool isFirstTimeUser;
  late UserDataFirebase user;
  late String deviceID;

  @override
  void initState() {
    super.initState();
  }

  Future<String> _getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String id = '';
    if (Platform.isAndroid) {
      const androidIdPlugin = AndroidId();
      id = await androidIdPlugin.getId() ?? 'Unknown ID';
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor ?? 'Unknown ID';
    }
    return id;
  }

  Future<List<dynamic>> firstTimeUser() async {
    String id = await _getDeviceID();
    UserDataFirebase user = UserDataFirebase(id);
    await user.initializationComplete();
    return [user, id];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Pals',
      home: FutureBuilder<List<dynamic>>(
        future: firstTimeUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            UserDataFirebase user = snapshot.data![0];
            bool isFirstTimeUser = user.isEmpty();
            return isFirstTimeUser ? const FirstTimeUser() : const HomePage();
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}


/*
class TaskPals extends StatelessWidget {
  const TaskPals({Key? key}) : super(key: key);

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
*/