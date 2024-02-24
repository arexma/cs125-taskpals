import 'package:flutter/material.dart';
import 'profile.dart';
import 'settings.dart';
import 'stats.dart';
import 'tasks.dart';

class ProfilePictureButton extends StatelessWidget {
  const ProfilePictureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const ProfileScreen()),
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

class StatsPageButton extends StatelessWidget {
  const StatsPageButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const Stats()),
        );
      },
      child: const Text('Stats',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
          )),
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
  const Home({super.key});

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
                    const Expanded(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            children: [
                              ProfilePictureButton(),
                              StatsPageButton(),
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
                                        builder: (context) => SettingsPage()));
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
