import 'package:flutter/material.dart';
import 'navigation.dart';

class Name extends StatefulWidget {
  final Navigation navigationWidget;
  const Name({super.key, required this.navigationWidget});

  @override
  State<Name> createState() => _Name();
}

class _Name extends State<Name> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
