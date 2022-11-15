// ignore_for_file: unused_import, implementation_imports, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();


  void loadLogin(BuildContext ctx) {
    Navigator.of(ctx).pushNamed('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 130, horizontal: 20),
        child: Column(children: [
          Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Create an Account",
                style: Theme.of(context).textTheme.caption,
              )),
          Text(
            "Create your account to be able to donate and help others in need",
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            height: 35,
          ),
          TextField(
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.bodyText1,
              hintText: 'Name',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                borderSide: BorderSide.none,
              ),
            ),
            controller: nameController,
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintStyle: Theme.of(context).textTheme.bodyText1,
              hintText: 'Phone Number',
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                borderSide: BorderSide.none,
              ),
            ),
            controller: contactController,
          ),
          SizedBox(
            height: 15,
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
            height: 25,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ))),
                onPressed: () {},
                child: Text(
                  "Create Account",
                  style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                )),
          ),
          SizedBox(
            height: 25,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Have an account?",
                style: TextStyle(color: Colors.black),
              ),
              GestureDetector(
                  onTap: () {
                    loadLogin(context);
                  },
                  child: Text(
                    " Login",
                    style: Theme.of(context).textTheme.bodyText2,
                  ))
            ],
          )
        ]),
      ),
    ));
  }
}
