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
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const Text('Name'),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
