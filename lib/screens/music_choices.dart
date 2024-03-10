import 'package:flutter/material.dart';
import 'package:pixelarticons/pixelarticons.dart';
import 'package:taskpals/main.dart';

class MusicItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  const MusicItem({
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
            icon: const Icon(Pixel.play),
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
  final MusicPlayer player;
  const MusicChoices({super.key, required this.player});

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: const Text("Music Selection"),
      content: const Text("Change the Background Music"),
      actions: <Widget> [
        MusicItem(
          title: "Spring (It's a Big World Outside).mp3",
          onTap: () {
            player.changeSong("Spring (It's a Big World Outside).mp3");
          },
        ),
        MusicItem(
          title: "Select a File!.mp3",
          onTap: () {
            player.changeSong("Select a File!.mp3");
          },
        ),
        MusicItem(
          title: "Snowdin Town.mp3",
          onTap: () {
            player.changeSong("Snowdin Town.mp3");
          },
        ),
        MusicItem(
          title: "Zen Garden.mp3",
          onTap: () {
            player.changeSong("Zen Garden.mp3");
          },
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Close"),
        ),
      ],
    );
  }
}