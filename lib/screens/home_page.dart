import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health/health.dart';
import 'package:provider/provider.dart';
import 'package:taskpals/main.dart';
import 'profile.dart';
import 'tasks.dart';
import 'pets.dart';
import 'gacha.dart';
import 'home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 2;

  // Get daily steps from healthkit
  int dailySteps = 0;
  HealthFactory health = HealthFactory();



  Future fetchStepData() async {
    int? steps;

    var types = [
      HealthDataType.STEPS,
      HealthDataType.SLEEP_SESSION,
    ];

    bool requested = await health.requestAuthorization(types);

    var currentTime = DateTime.now();
    var midnight = DateTime(currentTime.year, currentTime.month, currentTime.day);

    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
      currentTime.subtract(const Duration(days: 1)), currentTime, types
    );

    types = [
      HealthDataType.STEPS,
      HealthDataType.SLEEP_SESSION,
    ];
    var permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE,
    ];
    await health.requestAuthorization(types, permissions: permissions);

    bool success = await health.writeHealthData(10, HealthDataType.STEPS, currentTime, currentTime);
    success = await health.writeHealthData(3.1, HealthDataType.SLEEP_SESSION, currentTime, currentTime);

    if (requested) {
      steps = await health.getTotalStepsInInterval(midnight, currentTime);

      setState(() {
        dailySteps = (steps == null) ? 0 : steps;
      });
    }
  }

  // Sets the state of the GNav bar whenever pressed
  void navigateBottomBar(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  // Screens to navigate through via GNav bar
  final List<Widget> pages = [
    const ProfileScreen(),
    const TasksPageStarter(),
    const Home(),
    const Pets(),
    GachaScreen()
  ];

  @override
  Widget build(BuildContext context) {
    // Create the initial instance of the music player
    final player = Provider.of<MusicPlayer>(context);
    
    return MaterialApp(
      home: Scaffold(
        body: pages[currentPageIndex],
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: GNav(
              selectedIndex: currentPageIndex,
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.brown.shade900,
              gap: 8,
              onTabChange: navigateBottomBar,
              padding: const EdgeInsets.all(15),
              tabs: const [
                GButton(
                  icon: Icons.account_circle,
                  text: 'Profile'),
                GButton(
                  icon: Icons.assignment_late,
                  text: 'Tasks',
                ),
                GButton(
                  icon: Icons.house,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.pets,
                  text: 'Pets',
                ),
                GButton(
                  icon: Icons.credit_card,
                  text: 'Gacha',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
