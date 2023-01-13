// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class FoodRequest {
  String foodName;
  String address;
  String foodType;
  String mealType;
  int qty;
  int hrs;
  List<dynamic> imageUrls;
  String userId;
  String? status = 'Pending';
  String? toAddress;
  FoodRequest(
      {required this.foodName,
      required this.address,
      required this.foodType,
      required this.mealType,
      required this.qty,
      required this.hrs,
      required this.imageUrls,
      required this.userId,
      required this.toAddress,
      this.status});
}
