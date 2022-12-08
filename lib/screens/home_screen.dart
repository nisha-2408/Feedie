// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, unnecessary_import, implementation_imports, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables

import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isInit = true;
  var isLoading = false;

  int selectedIndex = 0;

  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      //print(isLoading);
        Provider.of<UserData>(context).fetchUserData().then((value) {
          setState(() {
            isLoading = false;
          });
        });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userData = Provider.of<UserData>(context, listen: false);
    return Scaffold(
      // ignore: prefer_const_constructors
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Center(child: Text(_userData.name)),
                TextButton(
                    onPressed: () {
                      Provider.of<Auth>(context, listen: false).logOut();
                    },
                    child: Text("LogOut"))
              ],
            ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 187, 187, 187),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Color.fromARGB(255, 58, 57, 57),
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: selectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity),
            label: 'Activity'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.volunteer_activism),
            label: 'Donate'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Spot'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}
