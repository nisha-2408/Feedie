// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Activity')),
      body: Center(child: Text('We have to discuss what to add here...'))
    );
  }
}