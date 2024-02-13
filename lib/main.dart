import 'package:flutter/material.dart';
import 'screens/gacha.dart';
import 'screens/home_page.dart';
import 'screens/first_time_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';
import 'services/user_data.dart';

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
  const TaskPals({Key? key}) : super(key: key);

  @override
  State<TaskPals> createState() => _TaskPals();
}

class _TaskPals extends State<TaskPals> {
  // Probably want to have global state management for database
  // connection, deviceID, and maybe isFirstTimeUser (?)
  bool? isFirstTimeUser;
  late UserDataFirebase user;
  late String deviceID;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _getDeviceID(BuildContext context) async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? id;
    if (Theme.of(context).platform == TargetPlatform.android) {
      const androidIdPlugin = AndroidId();
      id = await androidIdPlugin.getId();
    } else if (Theme.of(context).platform == TargetPlatform.iOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      id = iosInfo.identifierForVendor;
    }

    setState(() {
      if (id == null) {
        // Error handling if we can't extract device ID
      } else {
        deviceID = id;
      }
    });
  }

  Future<void> firstTimeUser(BuildContext context) async {
    await _getDeviceID(context);
    user = UserDataFirebase(deviceID);
    await user.initializationComplete();
    setState(() {
      isFirstTimeUser = user.isEmpty() ? true : false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Pals',
      home: FutureBuilder<void>(
        future: firstTimeUser(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return isFirstTimeUser! ? const FirstTimeUser() : const HomePage();
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Task Pals', initialRoute: '/first', routes: {
      '/first': (context) => const FirstTimeUser(),
    });
  }

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