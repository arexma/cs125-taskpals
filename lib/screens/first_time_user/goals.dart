import 'package:flutter/material.dart';

import 'navigation.dart';

List<String> goals = [
  'Sleep',
  'Nutrition',
  'Fitness',
  'Wellbeing',
  'Mental Health'
];

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
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'lib/assets/screen_backgrounds/first_time_user.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: <Widget>[
              const Spacer(),
              const Text(
                'What goals would you like to focus on?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 35.0,
                ),
              ),
              const Spacer(),
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.width * 0.9,
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ListView.builder(
                  itemCount: goals.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        goals[index],
                        style: const TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
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
              const Spacer(),
              widget.navigationWidget,
            ],
          ),
        ],
      ),
    );
  }
}
