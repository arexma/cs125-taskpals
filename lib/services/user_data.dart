// Retrieves saved information about user from file/database
// Current user info template:

//    name --> string
//    id --> string
//    height --> int (inches)
//    weight --> int
//    age --> int
//    currency --> int
//    pals_collected --> [int] (unique pal ids)
//    tasks --> [string] (task descriptions)
//    tasks_completed --> [string]
//    tasks_deleted --> [string]
//    goals --> [string]
//    pfp --> string

// TODO
//  Error handling

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import "package:path_provider/path_provider.dart";
import "package:cloud_firestore/cloud_firestore.dart";

const userFields = [
  "name",
  "id",
  "height",
  "weight",
  "age",
  "currency",
  "pals_collected",
  "tasks",
  "tasks_completed",
  "tasks_deleted",
  "goals",
  "pfp",
];

// Access user data from Firebase database

// Class useflow:
// 1. Create class using unique device ID
//    UserDataFirebase user = UserDataFirebase(<unique device id>);
// 2. Wait for initialization to complete before performing any functions
//    await test.initializationComplete()
// 3. Check if there was a user with that id in the database
//    test.isEmpty()
//    - If test.isEmpty() returns true, write to database with collected user data
//      await test.writeToDatabase(<unique device id>, <data>);
//    - Else, you can use the class as expected

// IMPORTANT: Any methods that are async need to be awaited or else your program
// won't work as expected.
class UserDataFirebase {
  Map<String, dynamic> data = {};
  late String id;
  late CollectionReference users;
  late Completer<void> _initCompleter;

  UserDataFirebase(String id) {
    _initCompleter = Completer<void>();
    init(id);
  }

  Future<void> init(String id) async {
    users = FirebaseFirestore.instance.collection('users');
    var flag = (await users.doc(id).get()).data();
    if (flag != null) {
      data = flag as Map<String, dynamic>;
    }
    this.id = id;
    _initCompleter.complete();
  }

  // Check if initialization is complete
  Future<void> initializationComplete() {
    return _initCompleter.future;
  }

  // Check if user exists in database
  bool isEmpty() {
    return data.isEmpty;
  }

  // Make sure to call this if data is empty upon initialization
  Future<bool> writeToDatabase(Map<String, dynamic> data) async {
    try {
      await users.doc(id).set(data);
      this.data = data;
      return true;
    } catch (e) {
      return false;
    }
  }

  // Returns user data if fields not specified
  Map<String, dynamic> queryByUniqueID([List<String>? fields]) {
    Map<String, dynamic> res = fields == null ? data : {};
    if (fields != null) {
      for (String field in fields) {
        res[field] = data[field];
      }
    }
    return res;
  }

  // Update user by field
  // Returns true if successful, false otherwise
  Future<bool> updateDatabase(Map<String, dynamic> modifiedData) async {
    try {
      DocumentReference userDocument = users.doc(id);
      await userDocument.update(modifiedData);
      data = (await userDocument.get()).data() as Map<String, dynamic>;
      return true;
    } catch (e) {
      return false;
    }
  }
}

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
      return;
    }
  }
}
