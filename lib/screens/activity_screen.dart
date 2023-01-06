// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Activity')), body: content());
  }

  Widget content() {
    final donations = List<String>.generate(5, (index) => 'Donation $index');
    final length = 0;
    return  length == 0 ? 
    Center(child: Text('No donations as of now!'),)
     : Container(
      child: ListView.builder(
        itemCount: donations.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2)),
                  ]),
              child: ListTile(
                onTap: () {
                  Fluttertoast.showToast(
                      msg: "Status: Pending",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.orange,
                      textColor: Colors.white,
                      fontSize: 15);
                },
                leading: Image.asset("assets/images/food.png"),
                title: Text(donations[index]),
                subtitle: Text("Pending"),
              ),
            ),
          );
        }),
      ),
    );
  }
}
