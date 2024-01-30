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

import 'package:flutter/material.dart';
import '../utility/editable_field.dart';

// Need to create map based on saved user data
const Map<String, String> userInfo = {
  'Name': 'Alexander Rex Ma',
  'Height': '5\' 8"',
  'Weight': '135'
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
                ('lib/assets/pfp.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: userInfo.entries
                .map((entry) => buildRow(entry.key, entry.value))
                .toList(),
          ),
        ],
      ),
    );
  }
}

Widget buildRow(String label, String initialText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: Text(label),
      ),
      EditableTextField(initialText: initialText)
    ],
  );
}
