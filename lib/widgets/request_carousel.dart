// ignore_for_file: avoid_print, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:feedie/providers/ngo_food_request.dart';
import 'package:flutter/material.dart';
import 'package:feedie/models/request.dart';
import 'package:provider/provider.dart';

class RequestCarousel extends StatelessWidget {
  final List<Request> data;
  final bool? isNgo;
  const RequestCarousel({required this.data, this.isNgo = false});

  void _showDialog(BuildContext context, String id) {
    Widget yesDelete = TextButton(
              onPressed: () {
                Provider.of<NGORequest>(context, listen: false)
                    .deleteRequest(id).then((value) => Navigator.of(context).pop(true));
              },
              child: Text("Yes"));
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Are you sure?"),
        content: Text("Do you want to decline this request?"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: Text("No")),
          yesDelete
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return data.length == 0
        ? Center(
            child: Text('Nothing!!'),
          )
        : Column(
            children: <Widget>[
              SizedBox(
                height: 6.0,
              ),
              Container(
                height: isNgo! ? 220 : 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    Request request = data[index];
                    return Container(
                      margin: EdgeInsets.all(10.0),
                      width: 210.0,
                      child: Stack(
                        alignment: Alignment.topCenter,
                        children: <Widget>[
                          Positioned(
                            bottom: isNgo! ? null : -45.0,
                            child: Container(
                              margin: isNgo! ? null : EdgeInsets.only(top: 0),
                              height: 155.0,
                              width: 200.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          'Meals required : ${request.remaining <=0 ? request.mealsRequired : request.remaining}',
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Color.fromARGB(
                                                  255, 26, 26, 26),
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 1.0),
                                        ),
                                        Text(
                                          request.ngoName,
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        SizedBox(height: 2.0),
                                        Text(
                                          request.address,
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  isNgo!
                                      ? request.isFulFilled!
                                          ? SizedBox()
                                          : ElevatedButton(
                                              onPressed: () {
                                                _showDialog(
                                                    context, request.id);
                                              },
                                              child: Text('Decline'),
                                            )
                                      : SizedBox()
                                ],
                              ),
                            ),
                          ),
                          isNgo!
                              ? SizedBox()
                              : Container(
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
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Image(
                                          height: 180.0,
                                          width: 180.0,
                                          image: NetworkImage(request.imageUrl),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
