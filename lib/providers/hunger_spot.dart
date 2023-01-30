// ignore_for_file: unused_import, empty_catches, unused_local_variable, avoid_print, unnecessary_new

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class HungerSpot with ChangeNotifier {
  String? token;
  String? userId;
  List<String> ids = [];
  HungerSpot({required this.token, required this.userId});
  List<HungerSpotData> data = [];
  List<HungerSpotData> allData = [];

  Future<void> addHungerSpot(HungerSpotData data) async {
    try {
      final id =
          await FirebaseFirestore.instance.collection('HungerSpots').add({
        'address': data.address,
        'images': data.images,
        'now': DateTime(1975),
        'hungerSpotName': data.hungerSpotName,
        'population': data.population,
        'needed': data.population,
        'isApproved': data.isApproved,
        'userId': userId
      });
    } catch (error) {
      print(error);
    }
  }

  Future<void> getHungerSpot() async {
    data = [];
    allData = [];
    await FirebaseFirestore.instance
        .collection('HungerSpots')
        .get()
        .then((value) {
      var docs = value.docs.map((e) {
        ids.add(e.id);
        return e.data();
      });
      var i = 0;
      for (var element in docs) {
        HungerSpotData newData = new HungerSpotData(
            id: ids[i],
            now: DateTime.now(),
            images: element['images'],
            address: element['address'],
            population: element['population'],
            hungerSpotName: element['hungerSpotName']);
        i = i + 1;
        if (element['isApproved'] == false) {
          data.add(newData);
        } else {
          var data1 = element['now'] as Timestamp;
          print(element['population']);
          if (element['needed'] > 0 ||
              DateTime.now().difference(data1.toDate()).inHours > 5) {
            allData.add(newData);
          }
        }
      }
    });
  }

    Future<void> getAdminHungerSpot() async {
    data = [];
    allData = [];
    await FirebaseFirestore.instance
        .collection('HungerSpots')
        .get()
        .then((value) {
      var docs = value.docs.map((e) {
        ids.add(e.id);
        return e.data();
      });
      var i = 0;
      for (var element in docs) {
        HungerSpotData newData = new HungerSpotData(
            id: ids[i],
            now: DateTime.now(),
            images: element['images'],
            address: element['address'],
            population: element['population'],
            hungerSpotName: element['hungerSpotName']);
        i = i + 1;
        if (element['isApproved'] == false) {
          data.add(newData);
        } else {
          allData.add(newData);
        }
      }
    });
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
    await FirebaseFirestore.instance
        .collection('HungerSpots')
        .doc(id)
        .update({'isApproved': true}).then((value) {
      for (HungerSpotData item in data) {
        if (item.id == id) {
          data.removeAt(data.indexOf(item));
          break;
        }
        notifyListeners();
      }
    });
  }

  Future<void> rejectSpot(String id, bool isAll) async {
    await FirebaseFirestore.instance
        .collection('HungerSpots')
        .doc(id)
        .delete()
        .then((value) {
      for (HungerSpotData item in data) {
        if (item.id == id) {
          isAll
              ? allData.removeAt(allData.indexOf(item))
              : data.removeAt(data.indexOf(item));
          break;
        }
      }
    });

    print(allData.length);
    notifyListeners();
  }
}
