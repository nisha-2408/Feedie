// ignore_for_file: unused_import

import 'package:flutter/cupertino.dart';

class HungerSpotData {
  String? id = DateTime.now().toString();
  final List<dynamic> images;
  final String hungerSpotName;
  final String address;
  final int population;
  final bool isApproved = false;
  HungerSpotData(
      {
      this.id,
      required this.images,
      required this.address,
      required this.population,
      required this.hungerSpotName});
}
