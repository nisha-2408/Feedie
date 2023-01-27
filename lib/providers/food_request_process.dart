// ignore_for_file: use_rethrow_when_possible, unused_local_variable, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedie/models/food_request.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class FoodRequestProcess with ChangeNotifier {
  String? userId;
  FoodRequestProcess({required this.userId});
  List<FoodRequest> data = [];
  List<FoodRequest> datas = [];
  String name = '';
  String contact = '';
  List<String> ids = [];

  Future<void> addFoodRequest(
      FoodRequest data, bool isNGO, String id, int qty) async {
    try {
      await FirebaseFirestore.instance.collection('food-donation').add({
        'foodName': data.foodName,
        'address': data.address,
        'foodType': data.foodType,
        'mealType': data.mealType,
        'qty': data.qty,
        'hrs': data.hrs,
        'images': data.imageUrls,
        'userId': userId,
        'status': 'Pending',
        'toAddress': data.toAddress,
        'acceptedId': ''
      });
      if (isNGO) {
        if (qty - data.qty <= 0) {
          await FirebaseFirestore.instance
              .collection('ngo-requests')
              .doc(id)
              .update({'remaining': qty - data.qty, 'isFulfilled': true});
        } else {
          await FirebaseFirestore.instance
              .collection('ngo-requests')
              .doc(id)
              .update({'remaining': qty - data.qty});
        }
      } else {
        if (qty - data.qty >= 0) {
          await FirebaseFirestore.instance
              .collection('HungerSpots')
              .doc(id)
              .update({'remaining': 0, 'now': DateTime.now()});
        } else {
          await FirebaseFirestore.instance
              .collection('HungerSpots')
              .doc(id)
              .update({'remaining': qty - data.qty});
        }
      }
    } catch (err) {
      throw err;
    }
  }

  Future<void> getAllRequests() async {
    datas = [];
    try {
      await FirebaseFirestore.instance
          .collection('food-donation')
          .where('status', isEqualTo: 'Pending')
          .get()
          .then((value) {
        var docs = value.docs.map((e) {
          ids.add(e.id);
          return e.data();
        });
        var i = 0;
        for (var ele in docs) {
          FoodRequest newData = FoodRequest(
              id: ids[i],
              foodName: ele['foodName'],
              address: ele['address'],
              foodType: ele['foodType'],
              mealType: ele['mealType'],
              qty: ele['qty'],
              hrs: ele['hrs'],
              imageUrls: ele['images'],
              userId: ele['userId'],
              status: ele['status'],
              toAddress: ele['toAddress']);
          datas.add(newData);
          i++;
        }
      });
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> getFoodRequest() async {
    data = [];
    try {
      await FirebaseFirestore.instance
          .collection('food-donation')
          .where('userId', isEqualTo: userId)
          .get()
          .then((value) {
        var docs = value.docs.map((e) {
          return e.data();
        });
        for (var ele in docs) {
          FoodRequest newData = FoodRequest(
              foodName: ele['foodName'],
              address: ele['address'],
              foodType: ele['foodType'],
              mealType: ele['mealType'],
              qty: ele['qty'],
              hrs: ele['hrs'],
              imageUrls: ele['images'],
              userId: ele['userId'],
              status: ele['status'],
              toAddress: ele['toAddress']);
          data.add(newData);
        }
      });
    } catch (err) {
      throw err;
    }
  }

  List<FoodRequest> get requestData {
    return data;
  }

  List<FoodRequest> get requestDatas {
    return datas;
  }

  Future<void> getUserDetails(String id, String ids) async {
    await FirebaseFirestore.instance
        .collection('food-donation')
        .doc(ids)
        .update({'status': "Accepted", 'acceptedId': userId});
    await FirebaseFirestore.instance.collection('users').doc(id).get().then(
      (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        name = data['name'];
        contact = data['contact'];
        // ...
      },
      onError: (e) {
        print(e);
      },
    );
  }

  Future<void> doneRequest(String id) async {
    await FirebaseFirestore.instance
        .collection('food-donation')
        .doc(id)
        .update({'status': "Delivered"});
  }

  Future<void> getAccepted() async {
    datas = [];
    ids = [];
    try {
      await FirebaseFirestore.instance
          .collection('food-donation')
          .where('acceptedId', isEqualTo: userId,)
          .get()
          .then((value) {
        var docs = value.docs.map((e) {
          ids.add(e.id);
          return e.data();
        });
        var i = 0;
        for (var ele in docs) {
          FoodRequest newData = FoodRequest(
              id: ids[i],
              foodName: ele['foodName'],
              address: ele['address'],
              foodType: ele['foodType'],
              mealType: ele['mealType'],
              qty: ele['qty'],
              hrs: ele['hrs'],
              imageUrls: ele['images'],
              userId: ele['userId'],
              status: ele['status'],
              toAddress: ele['toAddress']);
          if(newData.status != 'Delivered'){
            datas.add(newData);
          }
          i++;
        }
      });
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Map<String, String> get UserInfo {
    return {'name': name, 'contact': contact};
  }
}
