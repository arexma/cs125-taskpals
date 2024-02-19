import 'package:flutter/material.dart';
import 'navigation.dart';

List<int> feet = List<int>.generate(5, (index) => index + 3);
List<int> inches = List<int>.generate(13, (index) => index);

class Biometrics extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  final Map<String, int> savedInfo;
  // Expecting:
  // height: int
  // weight: int
  // age: int

  const Biometrics({
    super.key,
    required this.navigationWidget,
    required this.updateData,
    required this.savedInfo,
  });

  @override
  State<Biometrics> createState() => _Biometrics();
}

class _Biometrics extends State<Biometrics> {
  Row rowGenerator(List<String> fields) {
    List<Widget> children = [];

    for (String field in fields) {
      children.add(
        DropdownMenu(
          dropdownMenuEntries: field == 'ft'
              ? feet
                  .map((String feet) =>
                      DropdownMenuEntry(label: feet, value: feet))
                  .toList()
              : inches
                  .map((String inches) =>
                      DropdownMenuEntry(label: inches, value: inches))
                  .toList(),
        ),
      );
      children.add(Text(field));
    }

    return Row(
      children: children,
    );
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
          const Text('Height'),
          rowGenerator(['ft', 'in']),
          const Text('Weight'),
          Row(),
          const Text('Age'),
          Row(),
          widget.navigationWidget,
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int dropdownValue = 0; // saved value

  @override
  Widget build(BuildContext context) {
    return DropdownButton<int>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      onChanged: (int? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: feet.map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Text(value.toString()),
        );
      }).toList(),
    );
  }
}
