// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:feedie/screens/donation_screen.dart';
import 'package:flutter/material.dart';
import 'package:feedie/models/hunger_spot_data.dart';

class DisplayCard extends StatefulWidget {
  const DisplayCard({required this.item});
  final HungerSpotData item;
  @override
  State<DisplayCard> createState() => _DisplayCardState();
}

class _DisplayCardState extends State<DisplayCard> {
  void _showDialog(String img) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 200),
        content: Container(
          decoration:
              BoxDecoration(image: DecorationImage(image: NetworkImage(img))),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.item.hungerSpotName,
                style: TextStyle(
                    color: Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Text("Address: " + widget.item.address,
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 145, 145),
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              SizedBox(
                height: 8,
              ),
              Text("Population: " + widget.item.population.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 145, 145),
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              SizedBox(
                height: 8,
              ),
              Text("Images: ",
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 145, 145),
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              SizedBox(
                height: 8,
              ),
              Container(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.item.images.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showDialog(widget.item.images[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.item.images[index],
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(DonationScreen.routeName,
                        arguments: widget.item.address);
                  },
                  child: Text('Donate'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
