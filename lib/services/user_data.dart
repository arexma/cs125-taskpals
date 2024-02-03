// Retrieves saved information about user from file/database
// Info includes:
//    Currency
//    Name
//    Height
//    Weight
//    Pals collected
//    etc

import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import "package:path_provider/path_provider.dart";

class UserData {
  // Open up file
  late Map<String, dynamic> jsonData;

  // Reads data from json file and saves it to class, returns it as Map object
  Future<Map<String, dynamic>> readData() async {
    try {
      String content = await rootBundle.loadString('lib/assets/user_data.json');
      jsonData = json.decode(content);
      return jsonData;
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
