import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:taskpals/main.dart';

class MusicTile extends StatelessWidget {
  final String title;
  final Function() onTap;
  const MusicTile({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Ionicons.play),
            onPressed: onTap,
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}

class MusicChoices extends StatelessWidget {
  const MusicChoices({super.key});

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<MusicPlayer>(context);

    return AlertDialog(
      title: const Text("Music Selection"),
      content: const Text("Change the Background Music"),
      actions: <Widget> [
        MusicTile(
          title: "Spring (It's a Big World Outside).mp3",
          onTap: () {
            player.changeSong("Spring (It's a Big World Outside).mp3");
          },
        ),
        const SizedBox(width: 30),
        MusicTile(
          title: "Select a File!.mp3",
          onTap: () {
            player.changeSong("Select a File!.mp3");
          },
        ),
        const SizedBox(width: 30),
        MusicTile(
          title: "Snowdin Town.mp3",
          onTap: () {
            player.changeSong("Snowdin Town.mp3");
          },
        ),
        const SizedBox(width: 30),
        MusicTile(
          title: "Zen Garden.mp3",
          onTap: () {
            player.changeSong("Zen Garden.mp3");
          },
        ),
        const SizedBox(width: 30),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close")
        ),
      ],
    );
  }
}