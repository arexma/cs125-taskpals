import 'package:flutter/material.dart';

// Three different views:
// Only right arrow
// Both left and right arrow
// Left and right arrow, but right arrow calls a callback function

// TODO:
// Animate ElevatedButton
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
      row.add(
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: ElevatedButton(
            onPressed: () => controller.previousPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            ),
            child: const Icon(Icons.arrow_left),
          ),
        ),
      );
    }

    row.add(const Spacer());

    row.add(
      Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: ElevatedButton(
          onPressed: () {
            onRightArrowPressed?.call();
            if (onRightArrowPressed == null) {
              controller.nextPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              );
            }
          },
          child: const Icon(Icons.arrow_right),
        ),
      ),
    );

    return row;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment:
            showLeftArrow ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: createRow(),
      ),
    );
  }
}
