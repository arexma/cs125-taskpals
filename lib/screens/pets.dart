/*
Page to view the pet collection
*/
import 'package:flutter/material.dart';

import '../services/user_data.dart';

class Pets extends StatelessWidget {
  final UserDataFirebase user;
  const Pets({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
