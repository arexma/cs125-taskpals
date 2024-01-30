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
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Name:', // Add padding
              ),
              EditableTextField(
                initialText: 'Alexander Rex Ma',
              ), // Initial text set to saved user name
            ],
          ),
        ],
      ),
    );
  }
}
