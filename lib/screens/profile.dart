/* ideas: 
User-editable:
name
height
weight

Non-user-editable:

user data with healthkit stuff
calendar with progress done per day?
tasks done
pals collected (owned/possible)
height/weight
*/

// TODO:
// Maybe remove box around text unless the user is updating it
// Add task calendar
// Add user data w/ health-kit stuff
// Make pals collected not user editable
// Create userInfo map based on stored user data
// Maybe move screen up if the keyboard covers wherever the user is editing?
// Editable profile picture

import 'package:flutter/material.dart';
import '../utility/editable_field.dart';

const Map<String, String> userInfo = {
  'Name': 'Alexander Rex Ma',
  'Height': '5\' 8"',
  'Weight': '135',
  'Pals Collected': '4/20',
};

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const Center(
            child: Text(
              'Profile',
              style: TextStyle(
                color: Colors.black,
                fontSize: 45.0,
              ),
            ),
          ),
          SizedBox(
            width: 200.0,
            height: 200.0,
            child: ClipOval(
              child: Image.asset(
                ('lib/assets/pfp.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: userInfo.entries
                .map((entry) => buildColumn(entry.key, entry.value))
                .toList(),
          ),
        ],
      ),
      backgroundColor: Colors.amber[100],
    );
  }
}

Widget buildColumn(String label, String initialText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        EditableTextField(initialText: initialText),
      ],
    ),
  );
}
