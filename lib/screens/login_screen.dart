// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, avoid_web_libraries_in_flutter, avoid_print, must_be_immutable, unnecessary_null_comparison, duplicate_ignore, body_might_complete_normally_nullable, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:regexed_validator/regexed_validator.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var notShowPass = true;

  String email = "";

  String password = "";

  final _form = GlobalKey<FormState>();

  void loadSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/signup');
  }

  void loadForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed('/forgot_password');
  }

  void submitData() {
    // ignore: unnecessary_null_comparison
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(email);
    print(password);
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
                      "Wellcome Back!",
                      style: Theme.of(context).textTheme.caption,
                    )),
                Text(
                  "Nice to meet you! Please login to access and start donating to help others",
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
                          Theme.of(context).colorScheme.primary
                        )
                      ),
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
                  height: 5,
                ),
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        loadForgotPassword(context);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    )),
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
                        "Login",
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      )),
                ),
                SizedBox(
                  height: 55,
                  child: Text(
                    "or",
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(
                              image:
                                  AssetImage('assets/images/google_logo.png')),
                          Text(
                            "Google",
                            style:
                                TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                          ),
                        ],
                      )),
                ),
                SizedBox(
                  height: 45,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(color: Colors.black),
                    ),
                    GestureDetector(
                        onTap: () {
                          loadSignUp(context);
                        },
                        child: Text(
                          " Create Account",
                          style: Theme.of(context).textTheme.bodyText2,
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
