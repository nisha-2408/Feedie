// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:feedie/widgets/donation_request.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:feedie/widgets/hunger_spot_carousel.dart';
import 'package:feedie/widgets/request_carousel.dart';

class HomeWelcome extends StatefulWidget {
  const HomeWelcome({super.key});

  @override
  State<HomeWelcome> createState() => _HomeWelcomeState();
}

class _HomeWelcomeState extends State<HomeWelcome> {
  var isLoading = false;
  var isInit = true;
  @override
  void didChangeDependencies() {
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
    Map<String, dynamic> data =
        Provider.of<UserData>(context, listen: false).userData;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, ' + data['name'],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_on_outlined),
            color: Colors.black,
            iconSize: 28,
          )
        ],
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(),) : SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          children: <Widget>[
            SizedBox(height: 5.0),
            data['role'] == 'Volunteer' ? DonationRequest() : SizedBox(height: 0,),
            SizedBox(height: 5.0),
            RequestCarousel(),
            SizedBox(height: 15.0),
            HungerSpotCarousel(),
          ],
        ),
      ),
    );
  }
}
