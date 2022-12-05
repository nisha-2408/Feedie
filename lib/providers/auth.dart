// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_element, unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:async';

import 'package:feedie/models/http_exception.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  Timer? _authTimer;
  bool get isAuth {
    //print(token);
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

  String? get userId {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _userId != null) {
      return _userId;
    }
    return null;
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
    } catch (error) {
      throw error;
    }
    autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final _userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String()
    });
    prefs.setString('userData', _userData);
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
      _userId = responseData['localId'];
      final today = DateTime.now();
      _expiryDate = today.add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
    } catch (error) {
      throw error;
    }
    autoLogout();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final _userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String()
    });
    prefs.setString('userData', _userData);
    //print(json.decode(response.body));
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    //print(prefs.getString('userData'));
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
    final expires = DateTime.parse(extractedData['expiryDate'].toString());
    print(extractedData['expiryDate']);
    if (expires.isBefore(DateTime.now())) {
      print("checking expiry");
      return false;
    }
    _token = extractedData['token'].toString();
    _userId = extractedData['userId'].toString();
    _expiryDate = expires;
    notifyListeners();
    autoLogout();
    print("exiting autologin");
    return true;
  }

  Future<void> logOut() async {
    _expiryDate = null;
    _token = null;
    _userId = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    _authTimer = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final expiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiry), logOut);
  }
}
