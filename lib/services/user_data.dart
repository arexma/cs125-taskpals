// Retrieves saved information about user from file/database
// Info includes:

//    Name --> string
//    Unique id --> int
//    Height --> int (inches)
//    Weight --> int
//    Currency --> int
//    Pals collected --> [int] (unique pal ids)
//    tasks --> [string] (task descriptions)

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import "package:path_provider/path_provider.dart";
import "package:cloud_firestore/cloud_firestore.dart";

// Access user data from test files (for local testing)
class UserDataFile {
  // Open up file
  late Map<String, dynamic> data;

  // Reads data from json file and saves it to class, returns it as Map object
  Future<Map<String, dynamic>> readData() async {
    try {
      String content = await rootBundle.loadString('lib/assets/user_data.json');
      data = json.decode(content);
      return data;
    } catch (e) {
      // Log error
      print('Error reading file: $e');
      return {};
    }
  }

  Future<void> writeData(Map<String, dynamic> modifiedData) async {
    try {
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String appDocPath = appDocDir.path;

      String filePath = '$appDocPath/user_data.json';

      File file = File(filePath);
      String content = json.encode(modifiedData);
      await file.writeAsString(content);
    } catch (e) {
      // Log error
      print('Error writing to file $e');
    }
  }
}

// Access user data from Firebase database
class UserDataFirebase {
  late Map<String, dynamic> data;
  late CollectionReference users;

  UserDataFirebase() {
    users = FirebaseFirestore.instance.collection('users');
  }

  /*
  Future<void> readData() async {
    try {
      QuerySnapshot querySnapshot = await users.get();

      querySnapshot.docs.forEach((doc) {
        print('Document ID: ${doc.id}, Data: ${doc.data()}');
      });
    } catch (e) {
      print('Error reading data from Firestore: $e');
    }
  }
  */

  // queryByUniqueID(123, optional field parameter) --> either whole object or specific field
  Future<void> queryByUniqueID() async {}

  /*
  Future<void> writeToDatabase(String modifiedData) async {
    try {
      await users.add({
        'name': name,
      })
    }
  }
  */

  // Be able to add a new user first time accessing app

  // Update user by field
  Future<void> updateDatabase(
      String documentID, Map<String, dynamic> modifiedData) async {
    try {
      DocumentReference userDocument = users.doc(documentID);
      await userDocument.update(modifiedData);

      print('Updated document successfully!');
    } catch (e) {
      print("Error updated data in Firestore: $e");
    }
  }
}
