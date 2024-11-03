import 'dart:convert'; // For JSON decoding
import 'package:flutter/services.dart' show rootBundle; // For loading assets

class ListMarque {
  static List<Map<String, dynamic>> listUsers = [];

  static Future<void> loadUsers() async {
    String jsonString = await rootBundle.loadString('assets/marques.json');
    List<dynamic> jsonData = json.decode(jsonString);
    listUsers = List<Map<String, dynamic>>.from(jsonData);
  }
}
