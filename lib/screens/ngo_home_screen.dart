import 'package:flutter/material.dart';

class NGOHomeScreen extends StatelessWidget {
  const NGOHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('NGO Name'),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_on_outlined),
            color: Colors.black,
            iconSize: 28,
          )
        ],
      ),
      body: Center(child: Text('Hello NGO')),
    );
  }
}
