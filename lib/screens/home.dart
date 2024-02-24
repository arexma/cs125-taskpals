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
        margin: const EdgeInsets.only(bottom: 30),
        width: 80,
        height: 80,
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
              onTap: () {},
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
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: Stack(
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
            Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ProfilePictureButton(user: user),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const TasksListButton(),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SettingsPage(user: user)));
                              },
                              icon: const Icon(Icons.settings),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: Image(
                    alignment: Alignment.bottomCenter,
                    image: AssetImage('lib/assets/pets/Bulbasaur.gif'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
