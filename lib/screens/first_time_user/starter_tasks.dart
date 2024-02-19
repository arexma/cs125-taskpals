import 'package:flutter/material.dart';
import 'navigation.dart';

class StarterTasks extends StatefulWidget {
  final Navigation navigationWidget;
  const StarterTasks({super.key, required this.navigationWidget});

  @override
  State<StarterTasks> createState() => _StarterTasks();
}

class _StarterTasks extends State<StarterTasks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const Text('Starter Tasks'),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
