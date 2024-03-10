import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:health/health.dart';
import 'package:pixelarticons/pixel.dart';
import 'profile.dart';
import 'tasks.dart';
import 'pets.dart';
import 'gacha.dart';
import 'home.dart';
import '../services/user_data.dart';
import 'package:pixelarticons/pixelarticons.dart';

class HomePage extends StatefulWidget {
  final UserDataFirebase user;
  final int index;
  const HomePage({super.key, required this.user, required this.index});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int currentPageIndex;

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
    var midnight =
        DateTime(currentTime.year, currentTime.month, currentTime.day);

    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        currentTime.subtract(const Duration(days: 1)), currentTime, types);

    types = [
      HealthDataType.STEPS,
      HealthDataType.SLEEP_SESSION,
    ];
    var permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE,
    ];
    await health.requestAuthorization(types, permissions: permissions);

    bool success = await health.writeHealthData(
        10, HealthDataType.STEPS, currentTime, currentTime);
    success = await health.writeHealthData(
        3.1, HealthDataType.SLEEP_SESSION, currentTime, currentTime);

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
  late List<Widget> pages = [];
  @override
  void initState() {
    super.initState();
    currentPageIndex = widget.index;
    pages = [
      ProfileScreen(user: widget.user),
      TasksPageStarter(user: widget.user),
      Home(user: widget.user),
      Pets(user: widget.user),
      GachaPageStarter(user: widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              GButton(icon: Pixel.user, text: 'Profile'),
              GButton(
                icon: Pixel.clipboard,
                text: 'Tasks',
              ),
              GButton(
                icon: Pixel.home,
                text: 'Home',
              ),
              GButton(
                icon: Pixel.downasaur,
                text: 'Pets',
              ),
              GButton(
                icon: Pixel.dollar,
                text: 'Gacha',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
