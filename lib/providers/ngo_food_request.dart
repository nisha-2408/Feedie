// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedie/models/request.dart';
import 'package:flutter/cupertino.dart';

class NGORequest with ChangeNotifier {
  String? userId;
  String ngoName;
  String address;
  String contact;
  String imageUrl;
  List<String> ids = [];
  NGORequest(
      {required this.userId,
      required this.ngoName,
      required this.address,
      required this.imageUrl,
      required this.contact});
  List<Request> dataReq = [];
  List<Request> dataFill = [];
  int count = 0;

  Future<void> addRequest(Request data) async {
    try {
      await FirebaseFirestore.instance.collection('ngo-requests').add({
        'NGO': ngoName,
        'address': address,
        'contact': contact,
        'imageUrl': imageUrl,
        'mealType': data.mealType,
        'remaining': data.remaining,
        'qty': data.mealsRequired,
        'date': data.date,
        'isFulfilled': data.isFulFilled,
        'userId': userId
      }).then((value) => dataReq.add(data));
    } catch (e) {
      print(e);
    }
  }

  Future<void> fetchAllRequests() async {
    dataReq = [];
    ids = [];
    count = 0;
    await FirebaseFirestore.instance
        .collection('ngo-requests')
        .get()
        .then((value) {
      var docs = value.docs.map((e) {
        ids.add(e.id);
        return e.data();
      });
      var i = 0;
      for (var ele in docs) {
        Request newData = Request(
            id: ids[i],
            date: ele['date'],
            mealType: ele['mealType'],
            mealsRequired: ele['qty'],
            address: ele['address'],
            ngoName: ele['NGO'],
            imageUrl: ele['imageUrl'],
            isFulFilled: ele['isFulfilled'],
            remaining: ele['remaining'],
            contact: ele['contact']);
        if (!newData.isFulFilled!) {
          dataReq.add(newData);
        }
        i++;
        count++;
      }
    });
    notifyListeners();
  }

  Future<void> fetchRequests() async {
    dataReq = [];
    dataFill = [];
    ids = [];
    count = 0;
    await FirebaseFirestore.instance
        .collection('ngo-requests')
        .where('userId', isEqualTo: userId)
        .get()
        .then((value) {
      var docs = value.docs.map((e) {
        ids.add(e.id);
        return e.data();
      });
      var i = 0;
      for (var ele in docs) {
        Request newData = Request(
            id: ids[i],
            date: ele['date'],
            mealType: ele['mealType'],
            mealsRequired: ele['qty'],
            address: ele['address'],
            ngoName: ele['NGO'],
            imageUrl: ele['imageUrl'],
            isFulFilled: ele['isFulfilled'],
            remaining: ele['remaining'],
            contact: ele['contact']);
        newData.isFulFilled! ? dataFill.add(newData) : dataReq.add(newData);
        count++;
        i++;
      }
    });
    notifyListeners();
  }

  List<Request> get unFulFill {
    return dataReq;
  }

  List<Request> get fulFilled {
    return dataFill;
  }

  int get getCount {
    return count;
  }

  Future<void> deleteRequest(String id) async {
    await FirebaseFirestore.instance
        .collection('ngo-requests')
        .doc(id)
        .delete();
    notifyListeners();
  }
}
