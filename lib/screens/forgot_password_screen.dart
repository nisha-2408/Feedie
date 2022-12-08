// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, must_be_immutable, unused_field, body_might_complete_normally_nullable, unused_local_variable, unnecessary_null_comparison, duplicate_ignore

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  var notShowPass = true;

  String email = "";

  String password = "";

  final _form = GlobalKey<FormState>();

  void _showErrorDialog(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: isSuccess ? Text("Success!") : Text('An Error Occurred!'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future submitData() async {
    // ignore: unnecessary_null_comparison
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      final response =
          await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      _showErrorDialog(
          "Password reset email has been sent your registered mail!! After resetting the password please login", true);
    } catch (error) {
      _showErrorDialog("No user with $email was found!!", false);
    }
    _form.currentState!.reset();
    //Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
          child: Form(
            key: _form,
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
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 8.0,
                    ),
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    hintText: 'Email',
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
                    if (!validator.email(value!) || value == null) {
                      return "Please enter a valid email!";
                    }
                    return null;
                  }),
                  onSaved: ((newValue) {
                    email = newValue!;
                  }),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 25,
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
                      onPressed: submitData,
                      child: Text(
                        "Change Password",
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
