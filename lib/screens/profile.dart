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
    pfpPath = widget.user.queryByUniqueID(['pfp'])['pfp'] ??
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
                      fontSize: 45.0,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () async {
                    String newPath = await pickAndSaveImage();
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
                          widget.user.queryByUniqueID([entry.key])[entry.key],
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
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 4.0),
        label == 'Pals Collected' || label == 'Currency'
            ? Text(
                label == 'Pals Collected'
                    ? '${List<int>.from(initialText).length} / 151'
                    : initialText.toString(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              )
            : EditableTextField(
                initialText: initialText.toString(),
                textColor: Colors.black,
                boxWidth: MediaQuery.of(context).size.height * 0.8,
                boxHeight: MediaQuery.of(context).size.height * 0.05,
                textAlignment: Alignment.center,
                callback: callback,
              ),
      ],
    ),
  );
}
