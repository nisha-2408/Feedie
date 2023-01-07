// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_interpolation_to_compose_strings


import 'package:feedie/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWelcome extends StatelessWidget {
  const HomeWelcome({super.key});
  
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = Provider.of<UserData>(context, listen: false).userData;

    return Scaffold(
        appBar: AppBar(title: Text('Hello, '+data['name'])),
        // ignore: prefer_const_constructors
        body: Center(child: Text('Design goes here!!')));
  }
}
