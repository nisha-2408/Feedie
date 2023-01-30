// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, empty_statements, dead_code

import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/widgets/app_drawer.dart';
import 'package:feedie/widgets/hunger_spot_itm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  static const routeName = '/admin';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      Provider.of<HungerSpot>(
        context,
      ).getAdminHungerSpot().then((value) {
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
    final data = Provider.of<HungerSpot>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Admin')),
        drawer: AppDrawer(),
        // ignore: prefer_const_constructors
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.hungerData.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return HungerSpotItem(item: data.hungerData[index], isAll: false,);
                    },
                    itemCount: data.hungerData.length,
                  )
                : Center(
                    child: Text("No requests as of now!"),
                  ));
  }
}
