// ignore_for_file: use_rethrow_when_possible, avoid_print, unused_element, unused_import, unused_local_variable, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:async';

import 'package:feedie/models/http_exception.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  var gl = false;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
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

  Future googleLogin() async {
    gl = true;
    final googleuser = await googleSignIn.signIn();
    if (googleuser == null) {
      return;
    }
    _user = googleuser;
    final googleAuth = await googleuser.authentication;
    final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    final response =
        await FirebaseAuth.instance.signInWithCredential(credential);
    final user = FirebaseAuth.instance.currentUser;
    //print(response);
    var firebaseUser = FirebaseAuth.instance.currentUser;
    _token = await firebaseUser!.getIdToken(false);
    //print(response.user!.uid);
    _userId = response.user!.uid;
    //print(_userId);
    _expiryDate = DateTime.now().add(Duration(seconds: 3600));
    if (response.additionalUserInfo!.isNewUser) {
      final uri =
          "https://feedie-39c3c-default-rtdb.firebaseio.com/users.json?auth=$_token";
      final res = await http.post(Uri.parse(uri),
          body: json.encode({
            'name': response.user!.displayName,
            'email': response.user!.email,
            'contact': response.user!.phoneNumber,
            'imageUrl': response.user!.photoURL,
            'userId': response.user!.uid
          }));
    }
    //print(json.decode(res.body));
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    final _userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String()
    });
    prefs.setString('userData', _userData);
  }

  Future<void> signUp(
      String email, String password, String name, String phoneNumber) async {
    gl = false;
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
    gl = false;
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
    //print("exiting autologin");
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
    if (gl) {
      gl = false;
      await googleSignIn.disconnect();
      FirebaseAuth.instance.signOut();
    }
  }

  void autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final expiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: expiry), logOut);
  }
}
