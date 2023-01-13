// ignore_for_file: avoid_print, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:feedie/models/request.dart';

class RequestCarousel extends StatelessWidget {
  const RequestCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
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
                  onTap: () => print("See All"),
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
         SizedBox(height: 6.0,),
        Container(
          height: 300,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: requests.length,
            itemBuilder: (BuildContext context, int index) {
              Request request = requests[index];
              return Container(
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
                                'Meals required : ${request.mealsRequired}',
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: Color.fromARGB(255, 26, 26, 26),
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
                              height: 180.0,
                              width: 180.0,
                              image: AssetImage(request.imageUrl),
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
        )
      ],
    );
  }
}
