// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'package:feedie/models/request.dart';
import 'package:feedie/providers/ngo_food_request.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:feedie/screens/ngo_food_request.dart';
import 'package:feedie/widgets/request_carousel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NGOHomeScreen extends StatefulWidget {
  const NGOHomeScreen({super.key});

  @override
  State<NGOHomeScreen> createState() => _NGOHomeScreenState();
}

class _NGOHomeScreenState extends State<NGOHomeScreen> {
  var isInit = true;
  var isLoading = false;
  Map<String, dynamic> data = {};

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      data = Provider.of<UserData>(context, listen: false).userData;
      Provider.of<NGORequest>(context).fetchRequests().then((value) {
        setState(() {
          isLoading = false;
        });
      });

      //print(data);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  void _showDialog() {
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
          TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text("Yes")),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int count = Provider.of<NGORequest>(context, listen: false).getCount;
    List<Request> dataReq = Provider.of<NGORequest>(context, listen: false).unFulFill;
    List<Request> dataFill = Provider.of<NGORequest>(context, listen: false).fulFilled;
    return Scaffold(
      appBar: AppBar(
        title: Text(data['name']),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_on_outlined),
            color: Colors.black,
            iconSize: 28,
          )
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(25.0, 25.0, 25.0, 0.0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(blurRadius: 2.0, color: Colors.grey)
                    ]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 25.0, 5.0, 5.0),
                          child: Text(
                            'YOU RAISED',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 40.0, 5.0, 25.0),
                          child: Text(
                            count.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 40.0),
                          ),
                        )
                      ],
                    ),
                    SizedBox(width: 30.0),
                    GestureDetector(
                      onTap: () => Navigator.of(context)
                          .pushNamed(NGOFoodRequest.routeName),
                      child: Container(
                        height: 60.0,
                        width: 125.0,
                        decoration: BoxDecoration(
                            color: Colors.orangeAccent.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Center(
                          child: Text('Request More',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.orange)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 40.0),
          Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Raised Requests',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  )
                ],
              )),
          SizedBox(height: 10.0),
          RequestCarousel(data: dataReq, isNgo: true),
          SizedBox(height: 10.0),
          Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Fulfilled Requests',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0),
                  ),
                  Text(
                    'See all',
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0),
                  )
                ],
              )),
          RequestCarousel(data: dataFill, isNgo: true,)
        ],
      ),
    );
  }

  Widget _buildCard(
      String name, DateTime datetime, int cardIndex, int mealsRequired) {
    return SizedBox(
      height: 100,
      child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          elevation: 7.0,
          child: Column(
            children: <Widget>[
              SizedBox(height: 25.0),
              Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                datetime.toString().substring(0, 10),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black),
              ),
              SizedBox(height: 10.0),
              Text(
                "Meals Required : ",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black),
              ),
              SizedBox(height: 10.0),
              Text(
                mealsRequired.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0,
                    color: Colors.black),
              ),
              SizedBox(height: 20.0),
              Expanded(
                child: GestureDetector(
                  onTap: _showDialog,
                  child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0)),
                      ),
                      child: Center(
                        child: Text(
                          'Decline',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )),
                ),
              ),
            ],
          ),
          margin: cardIndex.isEven
              ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
              : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0)),
    );
  }
}
