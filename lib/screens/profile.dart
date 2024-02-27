/* ideas: 
User-editable:
name
height
weight
age

Non-user-editable:
user data with healthkit stuff
calendar with progress done per day?
tasks done
pals collected (owned/possible)
*/

// TODO:
// Maybe remove box around text unless the user is updating it
// Create userInfo map based on stored user data
// Maybe move screen up if the keyboard covers wherever the user is editing?
// Editable profile picture

import 'package:flutter/material.dart';
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

class ProfileScreen extends StatelessWidget {
  final UserDataFirebase user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
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
              children: fields.entries
                  .map(
                    (entry) => buildColumn(
                      entry.value,
                      user.queryByUniqueID([entry.key])[entry.key],
                      context,
                      (dynamic value) {
                        user.updateDatabase({entry.key: value});
                      },
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.lightBlue[100],
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
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        label == 'Pals Collected' || label == 'Currency'
            ? Text(
                label == 'Pals Collected'
                    ? '${List<int>.from(initialText).length} / 151'
                    : initialText.toString(),
              )
            : EditableTextField(
                initialText: initialText.toString(),
                boxWidth: MediaQuery.of(context).size.width * 0.8,
                boxHeight: MediaQuery.of(context).size.height * 0.05,
                textAlignment: Alignment.center,
                callback: callback,
              ),
      ],
    ),
  );
}
