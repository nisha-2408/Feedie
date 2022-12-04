import 'dart:convert';

import 'package:feedie/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData with ChangeNotifier {
  String token;
  String userId;
  UserData({required this.token, required this.userId});

  String name = "";
  String email = "";
  String imageUrl = "";
  String contact = "";
  Future<void> fetchUserData() async {
    final uri =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy=\"userId\"&equalTo=\"$userId\"";
    final response = await http.get(Uri.parse(uri));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach(((key, value) => name = value['name']));
    print(extractedData);
    notifyListeners();
  }
}
