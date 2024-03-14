import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:theme_provider/theme_provider.dart';
import 'settings.dart';
import '../services/user_data.dart';
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

class Home extends StatelessWidget {
  final UserDataFirebase user;
  final String pfpPath;

  Home({super.key, required this.user})
      : pfpPath = user.queryByField(['pfp'])['pfp'] ??
            'lib/assets/default_profile.png';

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
                    'Currency: \$${user.queryByField([
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
                TasksListButton(user: user),
                const Padding(padding: EdgeInsets.all(8.0)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage(user: user)));
                  },
                  icon: const Icon(Pixel.editbox),
                ),
              ],
            ),
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
