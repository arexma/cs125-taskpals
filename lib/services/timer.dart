import 'dart:async';
import 'package:flutter/material.dart';

class TimerService with ChangeNotifier {
  late Timer _timer;
  late void Function() callback;

  TimerService(this.callback) {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(minutes: 10), (timer) {
      callback();
    });
  }

  void _cancelTimer() {
    _timer.cancel();
  }
}
