// ignore_for_file: unused_import, implementation_imports, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, body_might_complete_normally_nullable, unnecessary_null_comparison, avoid_print, use_build_context_synchronously

import 'package:feedie/models/http_exception.dart';
import 'package:feedie/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var notShowPass = true;
  String name = "";
  String contact = "";
  String email = "";
  String password = "";
  var isLoading = false;
  var isError = false;
  final _form = GlobalKey<FormState>();

  bool terms = false;

  void loadLogin(BuildContext ctx) {
    Navigator.of(context).pop();
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
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

  Future<void> saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    try {
      setState(() {
        isLoading = true;
      });
      await Provider.of<Auth>(context, listen: false)
          .signUp(email, password, name, contact);
      setState(() {
        isLoading = false;
      });
    } on HttpException catch (error) {
      setState(() {
        isLoading = false;
      });
      isError = true;
      var errorMessage = 'Authentication failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'This email address is already in use.';
      } else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'This is not a valid email address';
      } else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'This password is too weak.';
      }
      _showErrorDialog(errorMessage);
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      isError = true;
      const errorMessage =
          "Could not authenticate you. Please try again later.";
      _showErrorDialog(errorMessage);
    }
    _form.currentState!.reset();
    if (!isError) {
      Navigator.of(context).pop();
    }
    //Navigator.pushNamed(context, '/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: isLoading ?
      Container(
          margin: EdgeInsets.symmetric(vertical: 150, horizontal: 20),
          alignment: Alignment.center,
          child: Column(
            children: [
              Text("Please Wait while we log you in :)", style: TextStyle(fontSize: 45),),
              CircularProgressIndicator()
            ],
          ),
        )
       : Container(
        margin: EdgeInsets.symmetric(vertical: 130, horizontal: 20),
        child: Form(
          key: _form,
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
            TextFormField(
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 8.0,
                ),
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
              textInputAction: TextInputAction.next,
              validator: ((value) {
                if (value == null) {
                  return "Please enter a name!";
                } else if (value.length < 5) {
                  return "Name can't be less than 5 characters";
                }
              }),
              onSaved: (newValue) {
                name = newValue!;
              },
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                errorStyle: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 8.0,
                ),
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
              textInputAction: TextInputAction.next,
              validator: ((value) {
                if (!validator.phone(value!) ||
                    value == null ||
                    value.length != 10) {
                  return "Please enter a valid phone number";
                }
                return null;
              }),
              onSaved: (newValue) {
                contact = newValue!;
              },
            ),
            SizedBox(
              height: 15,
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
                  icon: Icon(
                      notShowPass ? Icons.visibility : Icons.visibility_off),
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
              validator: ((value) {
                if (value == null || value.length < 8 || value.length > 12) {
                  return "Password must contain 8-12 characters!";
                }
              }),
              onSaved: ((newValue) {
                password = newValue!;
              }),
            ),
            Row(
              children: [
                Checkbox(
                  value: terms,
                  onChanged: (value) {
                    setState(() {
                      terms = value!;
                    });
                  },
                  activeColor: Colors.white,
                  checkColor: Theme.of(context).colorScheme.primary,
                ),
                Text('I agree to the ', style: TextStyle(color: Colors.grey)),
                Text("Terms of Services ",
                    style: TextStyle(color: Colors.orange)),
                Text("and ", style: TextStyle(color: Colors.grey)),
                Flexible(
                    child: Text("Privacy Policy ",
                        style: TextStyle(color: Colors.orange))),
              ],
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
                  onPressed: !terms
                      ? null
                      : () {
                          saveForm();
                        },
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
      ),
    ));
  }
}
