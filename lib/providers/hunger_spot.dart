// ignore_for_file: unused_import, empty_catches, unused_local_variable, avoid_print

import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HungerSpot with ChangeNotifier {
  String? token;
  String? userId;
  HungerSpot({required this.token, required this.userId});

  Future<void> addHungerSpot(HungerSpotData data) async {
    print(token);
    print(data.hungerSpotName);
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/HungerSpot.json?auth=$token";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'address': data.address,
            'images': data.images,
            'hungerSpotName': data.hungerSpotName,
            'population': data.population,
            'isApproved': data.isApproved,
            'userId': userId
          }));
      final responseData = json.decode(response.body);
      print(responseData);
    } catch (error) {
      print(error);
    }
  }
}
