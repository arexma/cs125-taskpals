/* 
Homepage (after login?) where the user can have a small view of tasks and navigate to other pages
*/
import 'package:flutter/material.dart';
import 'profile.dart';
import 'tasks.dart';
import 'pets.dart';
import 'gacha.dart';
import 'settings.dart';
import 'stats.dart';

class ProfilePictureButton extends StatelessWidget {
  const ProfilePictureButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProfileScreen()));
      },
      child: Container(
        width: 60,
        height: 60,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
        ),
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
            context, MaterialPageRoute(builder: (context) => const Stats()));
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
          )),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 2;

  final List<Widget> pages = [
    const ProfileScreen(),
    const TasksPageStarter(),
    const HomePage(),
    const Pets(),
    GachaScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ProfilePictureButton(),
                  Padding(padding: EdgeInsets.all(8.0)),
                  StatsPageButton(),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
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
                              builder: (context) => const Settings()));
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
              widthFactor: 0.7,
              child: Image(
                alignment: Alignment.bottomCenter,
                image: AssetImage('lib/assets/pets/test_image.jpg'),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          selectedItemColor: Colors.grey,
          unselectedItemColor: Colors.white,
          currentIndex: currentPageIndex,
          onTap: (index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()),
                  );
                },
                icon: const Icon(Icons.account_circle),
              ),
              label: 'Profile',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TasksPageStarter()),
                  );
                },
                icon: const Icon(Icons.assignment_late),
              ),
              label: 'Tasks',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                icon: const Icon(Icons.house),
              ),
              label: 'Home',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Pets()),
                  );
                },
                icon: const Icon(Icons.pets),
              ),
              label: 'Pets',
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => GachaScreen()),
                  );
                },
                icon: const Icon(Icons.credit_card),
              ),
              label: 'Gacha',
              backgroundColor: Colors.black,
            ),
          ],
          type: BottomNavigationBarType.fixed),
    ));
  }
}
