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

  @override
  void initState() {
    super.initState();
    pfpPath = widget.user.queryByField(['pfp'])['pfp'] ??
        'lib/assets/default_profile.png';
    timerService = Provider.of<TimerService>(context, listen: false);
    timerService.startTimer();
  }

  void feedPet() {}

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
            onPressed: () {
              feedPet();
            },
            child: const Text('Feed me!'),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: SizedBox(
            child: Image(
              image: AssetImage('lib/assets/pets/Squirtle.gif'),
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }
}

// Max size: 300 x 300