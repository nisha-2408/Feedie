// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_import

import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/widgets/app_drawer.dart';
import 'package:feedie/widgets/display_card.dart';
import 'package:feedie/widgets/hunger_spot_itm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HungerSpotDonate extends StatelessWidget {
  const HungerSpotDonate({super.key});
  static const routeName = '/hunger-spot-donate';

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<HungerSpot>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Hunger Spot')),
        // ignore: prefer_const_constructors
        body: data.allHungerData.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return DisplayCard(
                    item: data.allHungerData[index],
                  );
                },
                itemCount: data.allHungerData.length,
              )
            : Center(
                child: Text("No requests as of now!"),
              ));
  }
}
