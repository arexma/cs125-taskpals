import 'package:flutter/material.dart';

import 'name.dart';
import 'biometrics.dart';
import 'goals.dart';
import 'starter_tasks.dart';
import 'navigation.dart';

class FirstTimeUser extends StatefulWidget {
  // Callback to rebuild
  final VoidCallback updateUser;
  const FirstTimeUser({super.key, required this.updateUser});

  @override
  State<FirstTimeUser> createState() => _FirstTimeUser();
}

class _FirstTimeUser extends State<FirstTimeUser> {
  final PageController pageController = PageController();

  // Name only has right arrow, StartTasks right arrow needs
  // to call callback function
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: [
        Name(
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: false,
          ),
        ),
        Biometrics(
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: true,
          ),
        ),
        Goals(
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: true,
          ),
        ),
        StarterTasks(
          navigationWidget: Navigation(
            controller: pageController,
            showLeftArrow: true,
            onRightArrowPressed: widget.updateUser,
          ),
        ),
      ],
    );
  }
}
