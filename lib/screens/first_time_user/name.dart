import 'package:flutter/material.dart';

import '../../utility/editable_field.dart';
import 'navigation.dart';

class Name extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  final String savedName;

  const Name({
    super.key,
    required this.navigationWidget,
    required this.updateData,
    required this.savedName,
  });

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
          const SizedBox(height: 250.0),
          const Text(
            'Name ?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 45.0,
            ),
          ),
          const SizedBox(height: 50.0),
          EditableTextField(
            initialText: widget.savedName,
            callback: (dynamic value) {
              widget.updateData('name', value);
            },
          ), // initial text based on data
          const Spacer(),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
