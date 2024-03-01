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
        preferredSize: const Size.fromHeight(88.0),
        child: AppBar(),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/first_time_user/name_2.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const Spacer(),
              const Text(
                'What is your name?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.0,
                ),
              ),
              const SizedBox(height: 50.0),
              EditableTextField(
                initialText: widget.savedName,
                textAlignment: Alignment.center,
                callback: (dynamic value) {
                  widget.updateData('name', value);
                },
              ),
              const Spacer(),
              widget.navigationWidget,
            ],
          ),
        ],
      ),
    );
  }
}
