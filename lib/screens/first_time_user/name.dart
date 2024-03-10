import 'package:flutter/material.dart';

import 'dart:io';

import '../../utility/editable_field.dart';
import '../../services/pfp.dart';

import 'navigation.dart';

class Name extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  final Map<String, String> savedInfo;

  const Name({
    super.key,
    required this.navigationWidget,
    required this.updateData,
    required this.savedInfo,
  });

  @override
  State<Name> createState() => _Name();
}

class _Name extends State<Name> {
  late String pfpPath;
  late String savedName;

  @override
  void initState() {
    super.initState();
    pfpPath = widget.savedInfo['pfp']!;
    savedName = widget.savedInfo['name']!;
  }

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
                image: AssetImage('lib/assets/first_time_user/name.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  String newPath = await pickAndSaveImage(pfpPath);
                  setState(() {
                    pfpPath = newPath;
                  });
                  widget.updateData('pfp', pfpPath);
                },
                child: SizedBox(
                  width: 200.0,
                  height: 200.0,
                  child: ClipOval(
                      child: pfpPath.startsWith('lib/assets/')
                          ? Image.asset(pfpPath, fit: BoxFit.cover)
                          : Image.file(File(pfpPath), fit: BoxFit.cover)),
                ),
              ),
              const SizedBox(height: 25.0),
              const Text(
                'What is your name?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.0,
                ),
              ),
              const SizedBox(height: 25.0),
              EditableTextField(
                initialText: savedName,
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
