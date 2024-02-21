import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'screens/home_page.dart';
import 'services/user_data.dart';
import 'screens/first_time_user/first_time_user.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';

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

// MusicPlayer class to pass down to all future widgets to inherit
class MusicPlayer extends ChangeNotifier {
  late AudioPlayer player;

  MusicPlayer() {
    player = AudioPlayer();
    player.setLoopMode(LoopMode.one);
    player.setVolume(0.2);
    player.setAsset("lib/assets/audio/Spring (It's a Big World Outside).mp3");
    player.play();
  }

  AudioPlayer get currentPlayer => player;

  void changeSong(String songURL) {
    player.setAsset("lib/assets/audio/$songURL");
    player.play();
  }

  void dispose() {
    player.dispose();
    super.dispose();
  }
}

class TaskPals extends StatefulWidget {
  const TaskPals({super.key});

  @override
  State<TaskPals> createState() => _TaskPals();
}

class _TaskPals extends State<TaskPals> {
  late UserDataFirebase user;
  late bool isFirstTimeUser;

  @override
  void initState() {
    super.initState();
    _initializeUser();
  }

  Future<void> _initializeUser() async {
    UserDataFirebase temp = await firstTimeUser();
    setState(() {
      user = temp;
      isFirstTimeUser = user.isEmpty();
    });
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

  Future<UserDataFirebase> firstTimeUser() async {
    String id = await _getDeviceID();
    UserDataFirebase user = UserDataFirebase(id);
    await user.initializationComplete();
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Pals',
      home: FutureBuilder<UserDataFirebase>(
        future: firstTimeUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return isFirstTimeUser
                ? FirstTimeUser(
                    updateParent: () {
                      setState(() {});
                    },
                    user: user,
                  )
                : ChangeNotifierProvider(
                    create: (context) => MusicPlayer(),
                    child: ThemeProvider(
                        saveThemesOnChange: true,
                        loadThemeOnInit: true,
                        child: ThemeConsumer(
                            child: Builder(
                                builder: (themeContext) => MaterialApp(
                                        title: 'Task Pals',
                                        initialRoute: '/login',
                                        theme:
                                            ThemeProvider.themeOf(themeContext)
                                                .data,
                                        routes: {
                                          '/login': (context) =>
                                              const HomePage(),
                                        })))));
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
