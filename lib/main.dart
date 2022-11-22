// ignore_for_file: prefer_const_constructors

import 'package:feedie/screens/forgot_password_screen.dart';
import 'package:feedie/screens/login_screen.dart';
import 'package:feedie/screens/signup_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: ThemeData()
              .colorScheme
              .copyWith(primary: Colors.orange, secondary: Colors.blue),
          fontFamily: 'Poppins',
          textTheme: ThemeData.light().textTheme.copyWith(
              bodyText1: TextStyle(
                color: Color.fromARGB(221, 138, 137, 137),
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
              caption: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.w900,
                  fontSize: 32),
              bodyText2: TextStyle(
                  color: Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.orange))),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/forgot_password': (context) => ForgotPassword()
      },
    );
  }
}
