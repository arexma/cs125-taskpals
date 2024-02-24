import 'package:flutter/material.dart';

import 'navigation.dart';

List<String> goals = ['Sleep', 'Nutrition', 'Fitness', 'Wellbeing'];

class Goals extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  final List<String> savedGoals;

  const Goals({
    super.key,
    required this.navigationWidget,
    required this.updateData,
    required this.savedGoals,
  });

  @override
  State<Goals> createState() => _Goals();
}

class _Goals extends State<Goals> {
  late List<String> checkedGoals;

  @override
  void initState() {
    super.initState();
    checkedGoals = widget.savedGoals;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(25.0),
        child: AppBar(),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 250.0),
          const Text(
            'What goals would you like to focus on?',
            style: TextStyle(
              color: Colors.black,
              fontSize: 25.0,
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.all(50.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView.builder(
                itemCount: goals.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(goals[index]),
                    leading: Checkbox(
                        value: checkedGoals.contains(goals[index]),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              checkedGoals.add(goals[index]);
                            } else {
                              checkedGoals.remove(goals[index]);
                            }
                            widget.updateData('goals', checkedGoals);
                          });
                        }),
                  );
                },
              ),
            ),
          ),
          const Spacer(),
          widget.navigationWidget,
        ],
      ),
    );
  }
}
