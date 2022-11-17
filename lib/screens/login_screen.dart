// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_import, avoid_web_libraries_in_flutter, avoid_print

import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void loadSignUp(BuildContext context) {
    Navigator.of(context).pushNamed('/signup');
  }

  void loadForgotPassword(BuildContext context) {
    Navigator.of(context).pushNamed('/forgot_password');
  }

  void submitData() {
    // ignore: unnecessary_null_comparison
    if (emailController.text == null && passwordController.text == null) {
      return;
    }
    print(emailController.text);
  }

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
              TextField(
                decoration: InputDecoration(
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
                controller: emailController,
              ),
              SizedBox(
                height: 15,
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
                            image: AssetImage('assets/images/google_logo.png')),
                        Text(
                          "Google",
                          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
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
    );
  }
}
