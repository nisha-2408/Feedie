// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore

import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/widgets/app_drawer.dart';
import 'package:feedie/widgets/hunger_spot_itm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AllHungerSpots extends StatefulWidget {
  const AllHungerSpots({super.key});
  static const routeName = '/all-name';

  @override
  State<AllHungerSpots> createState() => _AllHungerSpotsState();
}

class _AllHungerSpotsState extends State<AllHungerSpots> {
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
      ).getHungerSpot().then((value) {
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
            : data.allHungerData.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return HungerSpotItem(item: data.allHungerData[index], isAll: true,);
                    },
                    itemCount: data.allHungerData.length,
                  )
                // ignore: prefer_const_constructors
                : Center(
                    child: Text("No hunger spots added yet! "),
                  ));
  }
}
