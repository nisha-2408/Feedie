// ignore_for_file: use_rethrow_when_possible, avoid_print

import 'dart:convert';

import 'package:feedie/models/http_exception.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  bool get isAuth {
    print(token);
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _userId != null) {
      return _userId!;
    }
    return '';
  }

  Future<void> signUp(
      String email, String password, String name, String phoneNumber) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyBuXKRSKYd7CYjAu7h0KSy3HoC5CG1OuX4";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      //print(json.decode(response.body));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      } else {
        var token = responseData['idToken'];
        final uri =
            "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$token";
        final res = await http.post(Uri.parse(uri),
            body: json.encode({
              'name': name,
              'email': email,
              'contact': phoneNumber,
              'imageUrl': '',
              'userId': responseData['localId']
            }));
        print(json.decode(res.body));
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signIn(
    String email,
    String password,
  ) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyBuXKRSKYd7CYjAu7h0KSy3HoC5CG1OuX4";
    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      //print(_token);
      _userId = responseData['localId'];
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
    } catch (error) {
      throw error;
    }
    notifyListeners();
    //print(json.decode(response.body));
  }
}
