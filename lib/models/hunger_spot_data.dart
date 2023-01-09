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
      {this.id,
      required this.images,
      required this.address,
      required this.population,
      required this.hungerSpotName});
}

final List<HungerSpotData> hungerSpots = [
  HungerSpotData(
    images: [
      'assets/images/spot1.jpg',
    ],
    hungerSpotName: 'Spot 1',
    address: '404 Great St',
    population: 175,
  ),
  HungerSpotData(
    images: [
      'assets/images/spot2.jpg',
    ],
    hungerSpotName: 'Spot 2',
    address: '404 Great St',
    population: 30,
  ),
  HungerSpotData(
    images: [
      'assets/images/spot1.jpg',
    ],
    hungerSpotName: 'Spot 3',
    address: '404 Great St',
    population: 50,
  ),
];
