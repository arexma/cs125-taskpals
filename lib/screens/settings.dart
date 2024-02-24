import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskpals/screens/home_page.dart';
import 'package:taskpals/screens/music_choices.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:taskpals/main.dart';

class ForwardButton extends StatelessWidget {
  final Function() onTap;
  const ForwardButton({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: ThemeProvider.themeOf(context).data.focusColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(
          Ionicons.chevron_forward_outline,
          color: ThemeProvider.themeOf(context).data.hintColor,
        ),
      ),
    );
  }
}

class SettingSwitch extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final bool value;
  final Function(bool value) onTap;
  const SettingSwitch({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
              color: ThemeProvider.themeOf(context).data.hintColor,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Spacer(),
          Text(
            value ? "On":"Off",
            style: const TextStyle(
              fontSize: 15,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          CupertinoSwitch(
            value: value,
            onChanged: onTap,
          ),
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final Color bgColor;
  final Color iconColor;
  final IconData icon;
  final String? value;
  final Function() onTap;
  const SettingItem({
    super.key,
    required this.title,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.onTap,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: bgColor,
            ),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            title,
            style: TextStyle(
              color: ThemeProvider.themeOf(context).data.hintColor,
              fontSize: 15,
              fontWeight: FontWeight.w900,
            ),
          ),
          const Spacer(),
          value != null
            ? Text(
              value!,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            )
          : const SizedBox(),
          const SizedBox(
            width: 20,
          ),
          ForwardButton(
            onTap: onTap
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadSwitchState();
  }

  Future<void> _loadSwitchState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = prefs.getBool('option') ?? false;
    });
  }

  Future<void> saveSwitchState(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isDarkMode = value;
      prefs.setBool('option', isDarkMode);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
      appBar: AppBar(
        backgroundColor: ThemeProvider.themeOf(context).data.canvasColor,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          color: ThemeProvider.themeOf(context).data.hintColor,
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 100.0,
        toolbarHeight: 100.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Settings",
                style: TextStyle(
                  color: Colors.amber,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              SettingItem(
                title: "Notifications",
                bgColor: Colors.yellow.shade100,
                iconColor: Colors.yellow,
                icon: Ionicons.notifications,
                onTap: () {},
              ),
              const SizedBox(
                height: 100,
              ),
              SettingSwitch(
                title: "Dark Mode",
                bgColor: Colors.purple.shade100,
                iconColor: Colors.purple,
                icon: Ionicons.moon,
                value: isDarkMode,
                onTap: (value) {
                  saveSwitchState(value);
                  ThemeProvider.controllerOf(context).nextTheme();
                },
              ),
              const SizedBox(
                height: 100,
              ),
              SettingItem(
                title: "Music",
                bgColor: Colors.blue.shade100,
                iconColor: Colors.blue, 
                icon: Ionicons.musical_note,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext dialogContext) {
                      final player = Provider.of<MusicPlayer>(context, listen: false);
                      return MusicChoices(player: player,);
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
