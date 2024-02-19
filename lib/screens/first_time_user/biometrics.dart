import 'package:flutter/material.dart';
import 'navigation.dart';

class Biometrics extends StatefulWidget {
  final Navigation navigationWidget;
  const Biometrics({super.key, required this.navigationWidget});

  @override
  State<Biometrics> createState() => _Biometrics();
}

class _Biometrics extends State<Biometrics> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
