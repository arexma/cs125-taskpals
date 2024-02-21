import 'package:flutter/material.dart';
import '../../services/user_data.dart';

class FirstTimeUser extends StatelessWidget {
  VoidCallback updateParent;
  UserDataFirebase user;

  FirstTimeUser({Key? key, required this.updateParent, required this.user})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
