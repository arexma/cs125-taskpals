import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'tasks.dart';

import '../services/user_data.dart';

class ProfilePictureButton extends StatelessWidget {
  final UserDataFirebase user;
  const ProfilePictureButton({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProfileScreen(user: user),
          ),
        );
      },
      child: Container(
        width: 60,
        height: 60,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(shape: BoxShape.circle),
        child: Image.asset('lib/assets/default_profile.png'),
      ),
    );
  }
}

class TasksListButton extends StatelessWidget {
  const TasksListButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      width: 200.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: 3,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TasksPageStarter()));
              },
              child: ListTile(
                title: Text('Task $index'),
              ),
            );
          },
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  final UserDataFirebase user;
  const Home({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image for home page
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/assets/background.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                ProfilePictureButton(),
                Padding(padding: EdgeInsets.all(8.0)),
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
                const TasksListButton(),
                const Padding(padding: EdgeInsets.all(8.0)),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SettingsPage()));
                  },
                  icon: const Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: FractionallySizedBox(
            widthFactor: 0.5,
            child: Image(
              alignment: Alignment.bottomCenter,
              image: AssetImage('lib/assets/pets/Squirtle.gif'),
            ),
          ),
        ),
      ],
    );
  }
}
