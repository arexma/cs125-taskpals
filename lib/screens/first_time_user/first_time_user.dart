import 'package:flutter/material.dart';
import 'dart:math';
import '../../services/user_data.dart';

// Subscreens
import 'name.dart';
import 'biometrics.dart';
import 'goals.dart';
import 'starter_tasks.dart';
import 'navigation.dart';

class FirstTimeUser extends StatefulWidget {
  // Callback to rebuild
  final Function(Map<String, dynamic>) updateParent;
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
  int randomIndex = Random().nextInt(3);
  List<String> starterPals = [
    "Bulbasaur",
    "Charmander",
    "Squirtle",
  ];

  void writeToDatabase() {
    data['currency'] = 0;
    data['pals_collected'] = [
      {
        'name': starterPals[randomIndex],
        'hunger': 10,
        'status': true,
      }
    ];
    data['current_pal'] = starterPals[randomIndex];
    widget.updateParent(data);
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
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Name(
          savedInfo: {
            'name': data['name'] ?? '',
            'pfp': data['pfp'] ?? 'lib/assets/default_profile.png',
          },
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
