import 'package:flutter/material.dart';

// Three different views:
// Only right arrow
// Both left and right arrow
// Left and right arrow, but right arrow calls a callback function

class Navigation extends StatelessWidget {
  final PageController controller;
  final bool showLeftArrow;
  final VoidCallback? onRightArrowPressed;

  const Navigation(
      {super.key,
      required this.controller,
      required this.showLeftArrow,
      this.onRightArrowPressed});

  List<Widget> createRow() {
    List<Widget> row = <Widget>[];

    if (showLeftArrow) {
      row.add(ElevatedButton(
        onPressed: () => controller.previousPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        ),
        child: const Icon(Icons.arrow_left),
      ));
      row.add(const SizedBox(width: 16.0));
    }

    row.add(ElevatedButton(
      onPressed: () {
        onRightArrowPressed?.call();
        controller.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      },
      child: const Icon(Icons.arrow_right),
    ));

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: createRow(),
    );
  }
}
