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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const Text('Biometrics'),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
