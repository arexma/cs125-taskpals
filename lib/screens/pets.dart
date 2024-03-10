import 'package:flutter/material.dart';
import '../services/user_data.dart';
import 'dart:async';
import 'dart:io';

class Pets extends StatefulWidget {
  final UserDataFirebase user;
  const Pets({super.key, required this.user});

  @override
  State<Pets> createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  List<String> petFilePaths = [];

  @override
  void initState() {
    super.initState();
    loadPets();
  }

  Future<void> loadPets() async {
    Directory directory = Directory('lib/assets/pets');
    List<FileSystemEntity> petFiles = directory.listSync(recursive: false);

    for (var fileSystemEntity in petFiles) {
      petFilePaths.add(fileSystemEntity.path);
    }
    print(petFilePaths);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
      itemCount: petFilePaths.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {

          },
          child: Image(image: AssetImage(petFilePaths[index])),
        );
      }
    );
  }
}