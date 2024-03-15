import 'dart:async';
import 'package:flutter/material.dart';

class TimerService with ChangeNotifier {
  late Timer _timer;

  TimerService() {
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      print('Testing 123');
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }
}
