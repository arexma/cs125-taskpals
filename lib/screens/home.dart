import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'settings.dart';
import '../services/user_data.dart';
import '../services/timer.dart';
import 'dart:io';

class TasksListButton extends StatelessWidget {
  final UserDataFirebase user;
  const TasksListButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: 250.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: 3,
          itemBuilder: (context, index) {
            Map<String, dynamic> query = user.queryByField(['tasks']);
            return Text(query['tasks'][index]);
          },
        ),
      ),
    );
  }
}

class Home extends StatefulWidget {
  final UserDataFirebase user;

  const Home({super.key, required this.user});

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  late String pfpPath;
  late TimerService timerService;
  late String currentPal;
  late int hunger;
  late int currency;
  late bool status;

  @override
  void initState() {
    super.initState();
    pfpPath = widget.user.queryByField(['pfp'])['pfp'] ??
        'lib/assets/default_profile.png';

    Map<String, dynamic> data = widget.user
        .queryByField(['current_pal', 'pals_collected', 'currency', 'status']);

    currentPal = data['current_pal'];
    currency = data['currency'];

    for (Map<String, dynamic> pal
        in List<Map<String, dynamic>>.from(data['pals_collected'])) {
      if (pal['name'] == currentPal) {
        hunger = pal['hunger'];
        status = pal['status'];
      }
    }

    timerService = TimerService(() {
      if (status) {
        updateHunger(false);
      }
    });
  }

  void updateHunger(bool flag) async {
    List<Map<String, dynamic>> pals = List<Map<String, dynamic>>.from(
        widget.user.queryByField(['pals_collected'])['pals_collected']);

    if (currency >= 5) {
      widget.user.updateDatabase({
        'currency': widget.user.queryByField(['currency'])['currency'] -= 5
      });
    }

    setState(() {
      currency = widget.user.queryByField(['currency'])['currency'];
    });

    for (Map<String, dynamic> pal in pals) {
      if (pal['name'] == currentPal) {
        if (flag) {
          if (pal['hunger'] != 10) {
            pal['hunger'] += 1;
          }
        } else {
          pal['hunger'] -= 1;

          if (pal['hunger'] == 0) {
            pal['status'] = false;

            setState(() {
              status = false;
            });
          }
        }

        setState(() {
          hunger = pal['hunger'];
        });

        break;
      }
    }

    widget.user.updateDatabase({'pals_collected': pals});
  }

  void revivePet() {}

  @override
  Widget build(BuildContext context) {
    String backgroundPath =
        ThemeProvider.themeOf(context).data == ThemeData.dark()
            ? 'lib/assets/background/night.gif'
            : 'lib/assets/background/day.gif';

    return Stack(
      children: [
        // Background image for home page
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(backgroundPath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 80.0,
                  height: 80.0,
                  child: ClipOval(
                      child: pfpPath.startsWith('lib/assets/')
                          ? Image.asset(pfpPath, fit: BoxFit.cover)
                          : Image.file(File(pfpPath), fit: BoxFit.cover)),
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                Text(
                    'Currency: \$${widget.user.queryByField([
                          'currency'
                        ])['currency']}',
                    style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ))
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                TasksListButton(user: widget.user),
                const Padding(padding: EdgeInsets.all(8.0)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                SettingsPage(user: widget.user)));
                  },
                  icon: const Icon(Pixel.editbox),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: status == true
                ? hunger == 10 || currency < 5
                    ? null
                    : () => updateHunger(true)
                : () => revivePet(),
            child: Text(status == true ? 'Feed me!' : 'Revive me!'),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: status == true
              ? SizedBox(
                  child: Image(
                    image: const AssetImage('lib/assets/pets/Squirtle.gif'),
                    width: hunger * 30,
                    height: hunger * 30,
                    fit: BoxFit.contain,
                  ),
                )
              : const Image(
                  image: AssetImage('lib/assets/death.png'),
                ),
        ),
      ],
    );
  }
}
