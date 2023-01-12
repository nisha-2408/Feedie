// ignore_for_file: unused_import, avoid_print, prefer_is_not_empty

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  String role = "";
  var isAdmin = false;

  Map<String, dynamic> get userData {
    return {
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'contact': contact,
      'role': role
    };
  }

  Future<void> fetchUserData() async {
    //print("hi $token");
    await FirebaseFirestore.instance.collection('users').doc(userId).get().then(
      (DocumentSnapshot doc) {
        if (!doc.exists) {
          isAdmin = true;
          return;
        }
        final data = doc.data() as Map<String, dynamic>;
        if (data.isEmpty) {
          isAdmin = true;
        } else {
          name = data['name'];
          email = data['email'];
          imageUrl = data['imageUrl'];
          contact = data['contact'];
          role = data['role'];
        }
        // ...
      },
      onError: (e) {
        print(e);
      },
    );

    //print(keys);
    notifyListeners();
  }

  bool get getAdmin {
    return isAdmin;
  }

  Future<void> setUserRole(String role) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'role': role});
  }

  Future<void> setUserImage(String imagePath) async {
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({'imageUrl': imagePath});
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
    FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .update({info: det});
    notifyListeners();
  }
}
