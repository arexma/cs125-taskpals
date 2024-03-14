// TODO:
// Maybe remove box around text unless user clicks on an edit button.

import 'dart:io';

import 'package:flutter/material.dart';

import '../services/pfp.dart';
import '../utility/editable_field.dart';
import '../services/user_data.dart';

const Map<String, String> fields = {
  'name': 'Name',
  'height': 'Height (inches)',
  'weight': 'Weight (lbs)',
  'age': 'Age',
  'currency': 'Currency',
  'pals_collected': 'Pals Collected',
};

class ProfileScreen extends StatefulWidget {
  final UserDataFirebase user;
  const ProfileScreen({super.key, required this.user});

  @override
  State<ProfileScreen> createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  late String pfpPath;

  @override
  void initState() {
    super.initState();
    pfpPath = widget.user.queryByField(['pfp'])['pfp'] ??
        'lib/assets/default_profile.png';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/screen_backgrounds/profile.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const Center(
                  child: Text(
                    'Profile',
                    style: TextStyle(
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black,
                          offset: Offset(2.0, 2.0),
                          blurRadius: 4.0,
                        ),
                      ],
                      fontSize: 45.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String newPath = await pickAndSaveImage(pfpPath);
                    setState(() {
                      pfpPath = newPath;
                    });
                    widget.user.updateDatabase({'pfp': pfpPath});
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
                Column(
                  children: fields.entries
                      .map(
                        (entry) => buildColumn(
                          entry.value,
                          widget.user.queryByField([entry.key])[entry.key],
                          context,
                          (dynamic value) {
                            widget.user.updateDatabase({entry.key: value});
                          },
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget buildColumn(String label, dynamic initialText, BuildContext context,
    Function(dynamic) callback) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black,
                offset: Offset(2.0, 2.0),
                blurRadius: 4.0,
              ),
            ],
          ),
        ),
        const SizedBox(height: 4.0),
        label == 'Pals Collected' || label == 'Currency'
            ? Text(
                label == 'Pals Collected'
                    ? '${List<String>.from(initialText).length} / 151'
                    : initialText.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17.0,
                  shadows: [
                    Shadow(
                        color: Colors.black,
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0),
                  ],
                ),
              )
            : EditableTextField(
                initialText: initialText.toString(),
                textColor: Colors.white,
                boxWidth: MediaQuery.of(context).size.height * 0.8,
                boxHeight: MediaQuery.of(context).size.height * 0.05,
                backgroundColor: Colors.black45,
                textSize: 17.0,
                textShadow: const Shadow(
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                ),
                textAlignment: Alignment.center,
                callback: callback,
              ),
      ],
    ),
  );
}
