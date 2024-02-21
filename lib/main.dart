import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_provider/theme_provider.dart';
import 'screens/home_page.dart';
import 'services/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:just_audio/just_audio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  UserDataFirebase test = UserDataFirebase();
  await test.readData();
  runApp(TaskPals());
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

class TaskPals extends StatelessWidget {
  const TaskPals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Save themes and load them from device 
    return ChangeNotifierProvider(
      create: (context) => MusicPlayer(),
      child: ThemeProvider(
        saveThemesOnChange: true,
        loadThemeOnInit: true,
        child: ThemeConsumer(
          child: Builder(
            builder: (themeContext) => MaterialApp(
              title: 'Task Pals',
              initialRoute: '/login',
              theme: ThemeProvider.themeOf(themeContext).data,
              routes: {
                '/login': (context) => const HomePage(),
              }
            )
          )
        )
      )
    );
  }
}