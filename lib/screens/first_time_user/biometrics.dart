import 'package:flutter/material.dart';

import 'navigation.dart';
import '../../utility/editable_field.dart';

List<int> feet = List<int>.generate(5, (index) => index + 3);
List<int> inches = List<int>.generate(13, (index) => index);

class Biometrics extends StatefulWidget {
  final Navigation navigationWidget;
  final Function(String, dynamic) updateData;
  final Map<String, int> savedInfo;
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
  late int feet;
  late int inches;

  @override
  void initState() {
    super.initState();
    feet = widget.savedInfo['height']! ~/ 12;
    inches = widget.savedInfo['height']! % 12;
  }

  Row rowGenerator(List<String> fields) {
    List<Widget> children = [];

    for (String field in fields) {
      if (field == 'lbs' || field == 'years') {
        children.add(
          EditableTextField(
            initialText: field == 'lbs'
                ? widget.savedInfo['weight'] == -1
                    ? ''
                    : widget.savedInfo['weight'].toString()
                : widget.savedInfo['age'] == -1
                    ? ''
                    : widget.savedInfo['age'].toString(),
            boxWidth: MediaQuery.of(context).size.width * 0.20,
            boxHeight: MediaQuery.of(context).size.height * 0.05,
            textSize: 20.0,
            textAlignment: Alignment.center,
            callback: (dynamic value) {
              String key = field == 'lbs' ? 'weight' : 'age';
              widget.updateData(key, int.parse(value));
            },
          ),
        );
      } else {
        children.add(
          Menu(
            field: field,
            callback: (int value, String field) {
              field == 'ft' ? feet = value : inches = value;
              widget.updateData('height', feet * 12 + inches);
            },
            initialValue: field == 'ft' ? feet : inches,
          ),
        );
      }

      children.add(Padding(
        padding: const EdgeInsets.only(
          left: 8.0,
          right: 8.0,
        ),
        child: Text(
          field,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
      ));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: children,
    );
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
                'Height',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                ),
                textAlign: TextAlign.center,
              ),
              rowGenerator(['ft', 'in']),
              const Spacer(),
              const Text(
                'Weight',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                ),
                textAlign: TextAlign.center,
              ),
              rowGenerator(['lbs']),
              const Spacer(),
              const Text(
                'Age',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.0,
                ),
                textAlign: TextAlign.center,
              ),
              rowGenerator(['years']),
              const Spacer(),
              widget.navigationWidget,
            ],
          ),
        ],
      ),
    );
  }
}

class Menu extends StatefulWidget {
  final String field;
  final Function(int, String)? callback;
  final int initialValue;

  const Menu(
      {super.key,
      required this.field,
      this.callback,
      required this.initialValue});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  late List<int> selectedField;
  late int selectedValue;

  @override
  void initState() {
    super.initState();
    selectedField = widget.field == "ft" ? feet : inches;
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      initialSelection: selectedValue,
      textStyle: const TextStyle(fontSize: 25.0),
      onSelected: (value) {
        setState(() {
          selectedValue = value;
          widget.callback?.call(value, widget.field);
        });
      },
      dropdownMenuEntries: selectedField.map<DropdownMenuEntry>((value) {
        return DropdownMenuEntry(
          value: value,
          label: value.toString(),
        );
      }).toList(),
    );
  }
}
