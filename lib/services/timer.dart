import 'dart:async';
import 'package:flutter/material.dart';

class TimerService with ChangeNotifier {
  late Timer _timer;
  late void Function() callback;

  TimerService(this.callback) {
    _startTimer();
  }

  // Change to 10 seconds for demo
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) {
      callback();
    });
  }

  void cancelTimer() {
    _timer.cancel();
  }
}
