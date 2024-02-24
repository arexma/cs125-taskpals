import 'package:flutter/material.dart';
import '../../services/user_data.dart';

// Subscreens
import 'name.dart';
import 'biometrics.dart';
import 'goals.dart';
import 'starter_tasks.dart';
import 'navigation.dart';

class FirstTimeUser extends StatefulWidget {
  // Callback to rebuild
  final VoidCallback updateParent;
  final UserDataFirebase user;

  const FirstTimeUser({
    super.key,
    required this.updateParent,
    required this.user,
  });

  @override
  State<FirstTimeUser> createState() => _FirstTimeUser();
}

class _FirstTimeUser extends State<FirstTimeUser> {
  final PageController pageController = PageController();
  Map<String, dynamic> data = {};

  void writeToDatabase() {
    widget.user.writeToDatabase(data);
    widget.updateParent();
  }

  void addToData(String key, dynamic value) {
    setState(() {
      data[key] = value;
    });
  }

  // Name only has right arrow, StartTasks right arrow needs
  // to call callback function
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        Name(
          savedName: data['name'] ?? '',
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: false,
          ),
          updateData: addToData,
        ),
        Biometrics(
          savedInfo: {
            'height': data['height'] ?? 36,
            'weight': data['weight'] ?? -1,
            'age': data['age'] ?? -1,
          },
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: true,
          ),
          updateData: addToData,
        ),
        Goals(
          savedGoals: data['goals'] ?? [],
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: true,
          ),
          updateData: addToData,
        ),
        StarterTasks(
          savedTasks: data['tasks'] ?? [],
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: true,
            onRightArrowPressed: writeToDatabase,
          ),
          updateData: addToData,
        ),
      ],
    );
  }
}
