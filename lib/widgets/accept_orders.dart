import 'dart:io';

import 'package:feedie/models/food_request.dart';
import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AcceptData extends StatefulWidget {
  const AcceptData({required this.item});
  final FoodRequest item;

  @override
  State<AcceptData> createState() => _AcceptDataState();
}

class _AcceptDataState extends State<AcceptData> {
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
                widget.item.foodName,
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
                  itemCount: widget.item.imageUrls.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        _showDialog(widget.item.imageUrls[index]);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(
                          widget.item.imageUrls[index],
                          fit: BoxFit.cover,
                          width: 150,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Provider.of<FoodRequestProcess>(context, listen: false)
                          .doneRequest(widget.item.id);
                    },
                    child: Text('Mark as Done'),
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
