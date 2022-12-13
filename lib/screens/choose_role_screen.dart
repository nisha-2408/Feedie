// ignore_for_file: unnecessary_import, implementation_imports, prefer_const_constructors, use_build_context_synchronously

import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ChooseRole extends StatefulWidget {
  const ChooseRole({super.key});

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {
  int selectedRole = 1;
  List<String> li = ['Donor', 'Volunteer', 'NGO'];
  void submitData() async {
    await Provider.of<UserData>(context, listen: false)
        .setUserRole(li[selectedRole])
        .then(
      (value) {
        Provider.of<Auth>(context, listen: false).users = false;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(top: 250),
        child: Column(
          children: [
            Text(
              "Choose your role",
              style: TextStyle(color: Colors.black, fontSize: 28),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRole = 1;
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: selectedRole == 1
                                ? Theme.of(context).colorScheme.primary
                                : null,
                            border: selectedRole == 1
                                ? null
                                : Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary)),
                        child: Container(
                            padding: EdgeInsets.all(15),
                            child: Image(
                              image: AssetImage('assets/images/food.png'),
                              width: 55,
                              height: 55,
                            )),
                      ),
                    ),
                    Text(
                      'Donate',
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35), fontSize: 15),
                    ),
                    Text(
                      'Donate your food for the needy',
                      style: TextStyle(
                          color: Color.fromARGB(255, 132, 132, 132),
                          fontSize: 10),
                    )
                  ],
                ),
                Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedRole = 2;
                        });
                      },
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: selectedRole == 2
                              ? Theme.of(context).colorScheme.primary
                              : null,
                          border: selectedRole == 2
                              ? null
                              : Border.all(
                                  color: Theme.of(context).colorScheme.primary),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(15),
                            child: Image(
                              image:
                                  AssetImage('assets/images/fast-delivery.png'),
                              width: 55,
                              height: 55,
                            )),
                      ),
                    ),
                    Text(
                      'Food Soldier',
                      style: TextStyle(
                          color: Color.fromARGB(255, 35, 35, 35), fontSize: 15),
                    ),
                    Text(
                      'Deliver the food for the needy',
                      style: TextStyle(
                          color: Color.fromARGB(255, 132, 132, 132),
                          fontSize: 10),
                    )
                  ],
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedRole = 3;
                    });
                  },
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        color: selectedRole == 3
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        border: selectedRole == 3
                            ? null
                            : Border.all(
                                color: Theme.of(context).colorScheme.primary)),
                    child: Container(
                        padding: EdgeInsets.all(19),
                        child: Image(
                          image: AssetImage('assets/images/ngo.png'),
                          width: 55,
                          height: 55,
                        )),
                  ),
                ),
                Text(
                  'NGO',
                  style: TextStyle(
                      color: Color.fromARGB(255, 35, 35, 35), fontSize: 15),
                ),
                Text(
                  'Request food if needed',
                  style: TextStyle(
                      color: Color.fromARGB(255, 132, 132, 132), fontSize: 10),
                )
              ],
            ),
            SizedBox(
              height: 25,
            ),
            SizedBox(
              width: 150,
              height: 60,
              child: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ))),
                  onPressed: submitData,
                  child: Text(
                    "Submit",
                    style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
