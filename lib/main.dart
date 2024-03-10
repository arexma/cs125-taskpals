import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:android_id/android_id.dart';
import 'package:just_audio/just_audio.dart';
import 'screens/first_time_user/first_time_user.dart';
import 'screens/home_page.dart';
import 'services/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const TaskPals());
}

// MusicPlayer class to pass down to all future widgets to inherit
class MusicPlayer {
  final AudioPlayer player = AudioPlayer();

  MusicPlayer() {
    player.setLoopMode(LoopMode.one);
    player.setVolume(0.2);
    player.setAsset("lib/assets/audio/Spring (It's a Big World Outside).mp3");
    player.play();
  }

  Future<void> changeSong(String songURL) async {
    await player.setAsset("lib/assets/audio/$songURL");
    await player.play();
  }

  void dispose() {
    player.dispose();
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
  late String deviceID;

  Future<void> _initializeUser() async {
    await _getDeviceID();
    user = UserDataFirebase(deviceID);
    await user.initializationComplete();
    isFirstTimeUser = user.isEmpty();
  }

  Future<void> _getDeviceID() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    deviceID = 'Windows Testing';

    if (!kIsWeb) {
      if (Platform.isAndroid) {
        const androidIdPlugin = AndroidId();
        deviceID = await androidIdPlugin.getId() ?? 'Unknown ID';
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceID = iosInfo.identifierForVendor ?? 'Unknown ID';
      }
    }
  }

  Future<void> checkFirstTimeUser() async {
    await _initializeUser();
  }

  @override
  Widget build(BuildContext context) {
    final player = MusicPlayer();

    return MaterialApp(
      title: 'Task Pals',
      home: FutureBuilder<void>(
        future: checkFirstTimeUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return isFirstTimeUser
              ? FirstTimeUser(
                updateParent: (Map<String, dynamic> data) {
                  user.writeToDatabase(data);
                  setState(() {});
                },
                user: user,
              )
              : Provider<MusicPlayer>(
                create: (_) => player,
                builder: (context, child) {
                  return ThemeProvider(
                    saveThemesOnChange: true,
                    loadThemeOnInit: true,
                    child: ThemeConsumer(
                      child: Builder(
                        builder: (themeContext) => MaterialApp(
                          title: 'Task Pals',
                          initialRoute: '/login',
                          theme: ThemeProvider.themeOf(themeContext).data,
                          routes: {
                            '/login': (context) => HomePage(user: user, index: 2),
                          },
                        ),
                      ),
                    ),
                  );
                }
              );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
