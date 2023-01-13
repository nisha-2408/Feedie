// ignore_for_file: prefer_const_constructors

import 'package:feedie/screens/hunger_spot_donate.dart';
import 'package:feedie/screens/hunger_spot_map_screen.dart';
import 'package:flutter/material.dart';

class DonateToSceen extends StatelessWidget {
  const DonateToSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Hunger Spot')),
      body: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Image(
          image: AssetImage(
            'assets/images/deliver.png',
          ),
          width: 200.0,
          height: 200.0,
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Donate to NGO",
                    style: TextStyle(
                        color: Color.fromARGB(255, 42, 42, 42),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "You can donate to NGO who are in need of food right now.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 146, 145, 145),
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(HungerSpotMap.routeName);
                    },
                    child: Text('Donate'),
                  )
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Donate to Hunger Spots",
                    style: TextStyle(
                        color: Color.fromARGB(255, 42, 42, 42),
                        fontWeight: FontWeight.w500,
                        fontSize: 20),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                      "You can directly donate to hunger spots based on location and requirement.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 146, 145, 145),
                          fontWeight: FontWeight.w400,
                          fontSize: 15)),
                  SizedBox(
                    height: 8,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(HungerSpotDonate.routeName);
                    },
                    child: Text('Donate Now'),
                  )
                ],
              ),
            ),
          ),
        ),
      ]),
    );;
  }
}