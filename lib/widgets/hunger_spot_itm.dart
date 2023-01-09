// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, unused_import, use_key_in_widget_constructors

import 'dart:io';

import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HungerSpotItem extends StatefulWidget {
  const HungerSpotItem({required this.item, required this.isAll});
  final HungerSpotData item;
  final bool isAll;

  @override
  State<HungerSpotItem> createState() => _HungerSpotItemState();
}

class _HungerSpotItemState extends State<HungerSpotItem> {
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
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.item.images.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _showDialog(widget.item.images[index]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(widget.item.images[index]),
                            fit: BoxFit.fill),
                      ),
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  !widget.isAll
                      ? ElevatedButton(
                          onPressed: () {
                            Provider.of<HungerSpot>(context, listen: false)
                                .approveSpot(widget.item.id!);
                          },
                          child: Text('Approve'),
                        )
                      : SizedBox(),
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<HungerSpot>(context, listen: false)
                          .rejectSpot(widget.item.id!, widget.isAll);
                    },
                    child: !widget.isAll ? Text('Reject') : Text('Delete'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
