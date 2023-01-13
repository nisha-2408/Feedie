// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, unnecessary_import, implementation_imports, no_leading_underscores_for_local_identifiers, prefer_const_literals_to_create_immutables, unused_local_variable
//AsTR3KiHyBHxhmcOK-gEnwDxtrxorOniwJqsf7Ww4X8OuRgSrlibd5dZqsZZSylX
import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:feedie/screens/activity_screen.dart';
import 'package:feedie/screens/admin_screen.dart';
import 'package:feedie/screens/choose_role_screen.dart';
import 'package:feedie/screens/donate_to_screen.dart';
import 'package:feedie/screens/donation_screen.dart';
import 'package:feedie/screens/home_welcome_screen.dart';
import 'package:feedie/screens/hunger_spot_map_screen.dart';
import 'package:feedie/screens/hunger_spot_screen.dart';
import 'package:feedie/screens/ngo_home_screen.dart';
import 'package:feedie/screens/ngo_welcome_screen.dart';
import 'package:feedie/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  final List<Widget> pages = [
    HomeWelcome(),
    ActivityScreen(),
    DonateToSceen(),
    HungerSpotScreen(),
    ProfileScreen()
  ];

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
      Provider.of<UserData>(context).fetchUserData();
      Provider.of<FoodRequestProcess>(context).getFoodRequest().then((value) {
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
    bool isAdmin = Provider.of<UserData>(context, listen: false).getAdmin;
    return Scaffold(
      // ignore: prefer_const_constructors
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : isAdmin
              ? AdminScreen()
              : _userData.userData['role'] == 'NGO'
                  ? NGOWelcome()
                  : pages[selectedIndex],
      bottomNavigationBar: isLoading
          ? null
          : isAdmin || _userData.userData['role'] == 'NGO'
              ? null
              : BottomNavigationBar(
                  backgroundColor: Color.fromARGB(255, 187, 187, 187),
                  selectedItemColor: Theme.of(context).colorScheme.primary,
                  unselectedItemColor: Color.fromARGB(255, 58, 57, 57),
                  currentIndex: selectedIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: selectPage,
                  items: [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.home), label: 'Home'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.local_activity), label: 'Activity'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.volunteer_activism), label: 'Donate'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.location_on), label: 'Spot'),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.account_circle), label: 'Profile'),
                  ],
                ),
    );
  }
}
