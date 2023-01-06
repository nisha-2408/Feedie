// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:feedie/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var isInit = true;
  var isLoading = false;
  Map<String, String> data = {};
  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      data = Provider.of<UserData>(context, listen: false).userData;
      //print(data);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: Text('Profile')),
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      height: 210,
                      decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(50),
                          ))),
                  Container(
                      width: 50,
                      height: 55,
                      margin: EdgeInsets.only(left: 2, top: 210),
                      decoration: BoxDecoration(
                          color: Color.fromARGB(255, 249, 247, 247),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.orange,
                                spreadRadius: 50,
                                offset: Offset(-50, -50))
                          ])),
                ],
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.all(7),
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: data['imageUrl'] as String != ""
                                    ? NetworkImage(data['imageUrl'] as String)
                                    : AssetImage('assets/images/account.png')
                                        as ImageProvider,
                                fit: BoxFit.fill),
                          ),
                        ),
                        margin: EdgeInsets.only(top: 125, left: 120),
                        width: 160,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(80),
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 194, 194, 194),
                                  offset: Offset(0, 10),
                                  spreadRadius: 5,
                                  blurRadius: 20)
                            ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 265),
                        child: Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {},
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.camera_alt_outlined, color: Colors.orange,),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        data['name'] as String,
                        style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 62, 62, 62),),
                      )),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 350),
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    GestureDetector(
                      
                      onTap: () {},
                      child: Container(
                        
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 224, 224, 224)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 194, 194, 194),
                                  offset: Offset(0, 10),
                                  spreadRadius: 5,
                                  blurRadius: 20)
                            ]),
                        child: Row(
                          children: [
                            Icon(
                              Icons.manage_accounts_sharp,
                              color: Colors.blue,
                              size: 40,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Profile',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 62, 62, 62),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      
                      onTap: () {},
                      child: Container(
                        
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 224, 224, 224)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 194, 194, 194),
                                  offset: Offset(0, 10),
                                  spreadRadius: 5,
                                  blurRadius: 20)
                            ]),
                        child: Row(
                          children: [
                            Icon(
                              Icons.food_bank_rounded,
                              color: Colors.blue,
                              size: 40,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Donations',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 62, 62, 62),),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 15,),
                    GestureDetector(
                      
                      onTap: () {},
                      child: Container(
                        
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                            border: Border.all(
                                color: Color.fromARGB(255, 224, 224, 224)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                  color: Color.fromARGB(255, 194, 194, 194),
                                  offset: Offset(0, 10),
                                  spreadRadius: 5,
                                  blurRadius: 20)
                            ]),
                        child: Row(
                          children: [
                            Icon(
                              Icons.notifications_active_rounded,
                              color: Colors.blue,
                              size: 40,
                            ),
                            SizedBox(
                              width: 25,
                            ),
                            Text(
                              'Notifications',
                              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600, color: Color.fromARGB(255, 62, 62, 62),),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
