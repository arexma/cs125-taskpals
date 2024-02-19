import 'package:flutter/material.dart';
import 'navigation.dart';

class Goals extends StatefulWidget {
  final Navigation navigationWidget;
  const Goals({super.key, required this.navigationWidget});

  @override
  State<Goals> createState() => _Goals();
}

class _Goals extends State<Goals> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
