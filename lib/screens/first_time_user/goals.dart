import 'package:flutter/material.dart';
import 'navigation.dart';

class Goals extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  const Goals({
    super.key,
    required this.navigationWidget,
    required this.updateData,
  });

  @override
  State<Goals> createState() => _Goals();
}

class _Goals extends State<Goals> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const Text('Goals'),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
