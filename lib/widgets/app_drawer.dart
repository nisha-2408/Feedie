// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:feedie/providers/auth.dart';
import 'package:feedie/screens/admin_screen.dart';
import 'package:feedie/screens/all_hunger_spots.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Hello Admin!'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.location_on_rounded),
            enabled: true,
            focusColor: Color.fromARGB(221, 115, 115, 115),
            title: Text("All Hunger Spots"),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(AllHungerSpots.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notification_add),
            enabled: true,
            focusColor: Color.fromARGB(221, 115, 115, 115),
            title: Text("Approval Requests"),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AdminScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.logout_rounded),
            title: Text("Logout"),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logOut();
            },
          )
        ],
      ),
    );
  }
}
