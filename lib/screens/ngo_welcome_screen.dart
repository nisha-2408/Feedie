import 'package:feedie/screens/ngo_home_screen.dart';
import 'package:feedie/screens/ngo_profile_screen.dart';
import 'package:flutter/material.dart';

class NGOWelcome extends StatefulWidget {
  const NGOWelcome({super.key});

  @override
  State<NGOWelcome> createState() => _NGOWelcomeState();
}

class _NGOWelcomeState extends State<NGOWelcome> {
  int selectedIndex = 0;
  final List<Widget> pages = [NGOHomeScreen(), NGOProfile()];
  void selectPage(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
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
            icon: Icon(Icons.account_circle_rounded),
            label: 'Profile'
          ),
        ],
      ),
    );
  }
}