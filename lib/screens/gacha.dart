/*
Where the user can use in-app currency to roll for pets after earning their wage from tasks
*/

import 'package:flutter/material.dart';
import '../services/user_data.dart';

class GachaScreen extends StatelessWidget {
  final Future<Map<String, dynamic>> userData;

  GachaScreen({super.key})
      : userData = UserDataFile().readData();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: userData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Data is being fetched, will be more useful if we connect to database
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // Error occurred while grabbing data
          return Text('Error: ${snapshot.error}');
        } else {
          // Data was successfully retrieved, userData is saved into snapshot.data
          snapshot.data!.entries.forEach(print);
          return Text('Received data: ${snapshot.data!.entries}');
        }
      },
    );
  }
}
