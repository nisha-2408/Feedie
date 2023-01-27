// ignore_for_file: avoid_print, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:feedie/models/food_request.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:feedie/screens/accepted_request_screen.dart';
import 'package:flutter/material.dart';
import 'package:feedie/models/request.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DonationRequest extends StatefulWidget {
  const DonationRequest({super.key});

  @override
  State<DonationRequest> createState() => _DonationRequestState();
}

class _DonationRequestState extends State<DonationRequest> {
  void _showDialogue(String id, String ids) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
            child: Text('Do you want accept this request and collect food?')),
        actions: [
          ElevatedButton(
              onPressed: () {
                Provider.of<FoodRequestProcess>(context, listen: false)
                    .getUserDetails(id, ids)
                    .then((value) => _showOther());
              },
              child: Text("Accept"))
        ],
      ),
    );
  }

  void _showOther() {
    final data =
        Provider.of<FoodRequestProcess>(context, listen: false).UserInfo;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Container(
            child: Text("Name: ${data['name']}, Call: ${data['contact']}")),
        actions: [
          ElevatedButton(
              onPressed: () async {
                final Uri launchUri = Uri(
                  scheme: 'tel',
                  path: data['contact'],
                );
                await launchUrl(launchUri);
              },
              child: Text("Call"))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<FoodRequest> data = [];
    data = Provider.of<FoodRequestProcess>(context).requestDatas;
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // ignore: prefer_const_constructors
                Text(
                  'Donation Requests',
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                    color: Color.fromARGB(255, 26, 26, 26),
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  // ignore: prefer_const_constructors
                  child: Text(
                    'See All',
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
        SizedBox(
          height: 6.0,
        ),
        Container(
          height: 300,
          child: data.isEmpty ? Center(child: Text('No request yet!!'),) : ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => _showDialogue(data[index].userId, data[index].id),
                child: Container(
                  margin: EdgeInsets.all(10.0),
                  width: 210.0,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: <Widget>[
                      Positioned(
                        bottom: 15.0,
                        child: Container(
                          height: 155.0,
                          width: 200.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Quantity : ${data[index].qty}',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color.fromARGB(255, 26, 26, 26),
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1.0),
                                ),
                                SizedBox(height: 2.0),
                                Text(
                                  "Address: ${data[index].address}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text(
                                  "To Address: ${data[index].toAddress}",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20.0),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black26,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 6.0),
                          ],
                        ),
                        child: Stack(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              child: Image(
                                height: 160.0,
                                width: 160.0,
                                image: NetworkImage(data[index].imageUrls[0]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
