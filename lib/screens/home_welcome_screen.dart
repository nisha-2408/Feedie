import 'package:flutter/material.dart';

class HomeWelcome extends StatelessWidget {
  const HomeWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hello, {{name}}')),
      body: Center(child: Text('Design goes here!!'))
    );
  }
}
