// ignore_for_file: unused_import, empty_catches, unused_local_variable, avoid_print, unnecessary_new

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
  List<HungerSpotData> data = [];
  List<HungerSpotData> allData = [];

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

  Future<void> getHungerSpot() async {
    data = [];
    allData = [];
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/HungerSpot.json?auth=$token";
    final response = await http.get(Uri.parse(url));
    if (json.decode(response.body)==null) {
      return;
    }
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    //print(extractedData);
    extractedData.forEach(((key, value) {
      //print(value);
      HungerSpotData newData = new HungerSpotData(
          id: key,
          images: value['images'],
          address: value['address'],
          population: value['population'],
          hungerSpotName: value['hungerSpotName']);
      if (!value['isApproved'] == true) {
        data.add(newData);
      } else {
        allData.add(newData);
      }
    }));
  }

  List<HungerSpotData> get hungerData {
    //print(data.length);
    return data;
  }

  List<HungerSpotData> get allHungerData {
    //print(allData.length);
    return allData;
  }

  Future<void> approveSpot(String id) async {
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/HungerSpot/$id.json?auth=$token";
    final response = await http.patch(Uri.parse(url),
        body: json.encode({'isApproved': true}));
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    for (HungerSpotData item in data) {
      if (item.id == id) {
        data.removeAt(data.indexOf(item));
        break;
      }
    }
    print(data.length);
    notifyListeners();
  }

  Future<void> rejectSpot(String id, bool isAll) async {
    final url =
        "https://feedie-39c3c-default-rtdb.firebaseio.com/HungerSpot/$id.json?auth=$token";
    final response = await http.delete(Uri.parse(url));
    for (HungerSpotData item in data) {
      if (item.id == id) {
        isAll
            ? allData.removeAt(allData.indexOf(item))
            : data.removeAt(data.indexOf(item));
        break;
      }
    }
    print(allData.length);
    notifyListeners();
  }
}
