// ignore_for_file: unused_import, avoid_print

import 'dart:convert';

import 'package:feedie/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserData with ChangeNotifier {
  String? token;
  String? userId;
  UserData({required this.token, required this.userId});

  String name = "";
  String email = "";
  String imageUrl = "";
  String contact = "";
  String keys = "";

  Map<String, dynamic> get userData {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'contact': contact
    };
  }

  Future<void> fetchUserData() async {
    //print("hi $token");
    final uri =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy=\"userId\"&equalTo=\"$userId\"";
    final response = await http.get(Uri.parse(uri));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach(((key, value) {
      keys = key;
      name = value['name'];
      email = value['email'];
      imageUrl = value['imageUrl'];
      contact = value['contact'];
      //print(name);
    }));
    //print(keys);
    notifyListeners();
  }

  Future<void> setUserRole(String role) async {
    final uri =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy=\"userId\"&equalTo=\"$userId\"";
    final response = await http.get(Uri.parse(uri));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach(((key, value) {
      keys = key;
    }));
    print(keys);
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users/$keys.json?auth=$token";
    final responses =
        await http.patch(Uri.parse(url), body: json.encode({'role': role}));
    final responseData = json.decode(responses.body) as Map<String, dynamic>;
    print(responseData);
  }

  Future<void> setUserImage(String imagePath) async {
    final uri =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy=\"userId\"&equalTo=\"$userId\"";
    final response = await http.get(Uri.parse(uri));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach(((key, value) {
      keys = key;
    }));
    print(keys);
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users/$keys.json?auth=$token";
    final responses = await http.patch(Uri.parse(url),
        body: json.encode({'imageUrl': imagePath}));
    final responseData = json.decode(responses.body) as Map<String, dynamic>;
    print(responseData);
    imageUrl = imagePath;
    notifyListeners();
  }

  Future<void> setUserDetails(String det, bool isEmail) async {
    String info = 'email';
    if (!isEmail) {
      contact = det;
      info = 'contact';
    } else {
      email = det;
    }
    final uri =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$token&orderBy=\"userId\"&equalTo=\"$userId\"";
    final response = await http.get(Uri.parse(uri));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach(((key, value) {
      keys = key;
    }));
    print(keys);
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/users/$keys.json?auth=$token";
    final responses =
        await http.patch(Uri.parse(url), body: json.encode({info: det}));
    final responseData = json.decode(responses.body) as Map<String, dynamic>;
    print(responseData);
    notifyListeners();
  }
}
