// ignore_for_file: prefer_const_constructors, duplicate_ignore, prefer_interpolation_to_compose_strings

import 'package:feedie/models/request.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/providers/ngo_food_request.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:feedie/screens/accepted_request_screen.dart';
import 'package:feedie/screens/ngo_donate_screen.dart';
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
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      Provider.of<NGORequest>(context).fetchAllRequests();
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
    List<Request> dataReq =
        Provider.of<NGORequest>(context, listen: false).unFulFill;
    Map<String, dynamic> data =
        Provider.of<UserData>(context, listen: false).userData;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Hello, ' + data['name'],
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(FoodAcepted.routeName);
            },
            icon: Icon(Icons.done_all_rounded),
            color: Colors.black,
            iconSize: 28,
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                children: <Widget>[
                  SizedBox(height: 5.0),
                  data['role'] == 'Volunteer'
                      ? DonationRequest()
                      : SizedBox(
                          height: 0,
                        ),
                  SizedBox(height: 5.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Food Requests',
                            style: TextStyle(
                              color: Color.fromARGB(255, 26, 26, 26),
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.of(context)
                                .pushNamed(NGODonate.routeName),
                            // ignore: prefer_const_constructors
                            child: Text(
                              'See All',
                              // ignore: prefer_const_constructors
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ]),
                  ),
                  RequestCarousel(data: dataReq),
                  SizedBox(height: 15.0),
                  HungerSpotCarousel(),
                ],
              ),
            ),
    );
  }
}
