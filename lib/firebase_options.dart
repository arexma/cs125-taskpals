// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDjMUA9MZtihGnKDeaFColmi2eXvZ_bRds',
    appId: '1:857325271425:web:9097236558718ee21a5080',
    messagingSenderId: '857325271425',
    projectId: 'taskpals-82dd9',
    authDomain: 'taskpals-82dd9.firebaseapp.com',
    storageBucket: 'taskpals-82dd9.appspot.com',
    measurementId: 'G-KRZEKFR960',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDhsyElTJv1VkMCvCBgoR1ispg0IC-wHjY',
    appId: '1:857325271425:android:73c8e581691306581a5080',
    messagingSenderId: '857325271425',
    projectId: 'taskpals-82dd9',
    storageBucket: 'taskpals-82dd9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDE2h83kCWkscB56wDBJGhIztlrSGp0RVM',
    appId: '1:857325271425:ios:03c3e827ac15f91a1a5080',
    messagingSenderId: '857325271425',
    projectId: 'taskpals-82dd9',
    storageBucket: 'taskpals-82dd9.appspot.com',
    iosBundleId: 'com.example.taskpals',
  );
}
