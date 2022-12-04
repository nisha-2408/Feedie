// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, unused_field, body_might_complete_normally_nullable

import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var notShowPass = true;
  var notShowCPass = true;

  String password = "";

  String confirmPassword = "";

  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
        child: Form(
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
                TextFormField(
                  obscureText: notShowPass,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(notShowPass
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          notShowPass = !notShowPass;
                        });
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary)),
                    ),
                    errorStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 8.0,
                    ),
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
                  textInputAction: TextInputAction.next,
                  validator: ((value) {
                    if (value == null ||
                        value.length < 8 ||
                        value.length > 12) {
                      return "Password must contain 8-12 characters!";
                    }
                  }),
                  onSaved: ((newValue) {
                    password = newValue!;
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  obscureText: notShowCPass,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: Icon(notShowCPass
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          notShowCPass = !notShowCPass;
                        });
                      },
                      style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context).colorScheme.primary)),
                    ),
                    errorStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 8.0,
                    ),
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
                  validator: ((value) {
                    if (value == null ||
                        value.length < 8 ||
                        value.length > 12) {
                      return "Password must contain 8-12 characters!";
                    }
                  }),
                  onSaved: ((newValue) {
                    confirmPassword = newValue!;
                  }),
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
              ]),
        ),
      ),
    ));
  }
}
