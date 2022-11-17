// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});

  final confirmController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Change Password",
                      style: Theme.of(context).textTheme.caption,
                    )),
                Text(
                  "Change your password so that your account remains safe.",
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 35,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    hintText: 'Password',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: passwordController,
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    hintText: 'Confirm Password',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  controller: confirmController,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 155,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ))),
                      onPressed: () {},
                      child: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      )),
                ),
              ]
        ),
          ),
      )
    );
  }
}