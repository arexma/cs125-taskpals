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

import "package:path/path.dart";

class UserData {
  // Open up file
  late Map<String, dynamic> jsonData;

  // Reads data from json file and saves it to class, returns it as Map object
  Future<Map<String, dynamic>> readData() async {
    try {
      File file = File('lib/mock_data/user_data.json');
      String content = await file.readAsString();
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
      File file = File(join('lib', 'mock_data', 'user_data.json'));
      String content = json.encode(modifiedData);
      await file.writeAsString(content);
    } catch (e) {
      // Log error
      print('Error writing to file $e');
    }
  }
}
