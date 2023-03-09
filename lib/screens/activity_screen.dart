// ignore_for_file: prefer_const_constructors, prefer_const_declarations, avoid_unnecessary_containers, unused_local_variable

import 'package:feedie/models/food_request.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});
  static const routeName = '/donations';

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  showDialogFunc(context, index, img, address, foodType, mealType, quantity,
      time, toAddress) {
    return showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(15),
              height: 400,
              width: MediaQuery.of(context).size.width * 0.7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Image.network(
                      img,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    // width: 200,
                    child: Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text(
                            "Address : ${address}",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          Text(
                            "Food Type : ${foodType}",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          Text(
                            "Meal Type : ${mealType}",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          Text(
                            "Quantity : ${quantity}",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          Text(
                            "Time : ${time} hrs ago",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                          Text(
                            "To Address : ${toAddress}",
                            style: TextStyle(
                                fontSize: 18, color: Colors.grey[500]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  var isInit = true;
  var isLoading = false;
  List<FoodRequest> data = [];
  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      Provider.of<FoodRequestProcess>(context, listen: false)
          .getFoodRequest()
          .then((value) {
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
    return Scaffold(
        appBar: AppBar(title: Text('Activity')),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : content());
  }

  Widget content() {
    final donations = List<String>.generate(5, (index) => 'Donation $index');
    data = Provider.of<FoodRequestProcess>(context, listen: false).requestData;
    return data.isEmpty
        ? Center(
            child: Text('No donations as of now!'),
          )
        : Container(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                  child: Container(
                    height: 90,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: Offset(0, 2)),
                        ]),
                    child: GestureDetector(
                      child: ListTile(
                        onTap: () {
                          showDialogFunc(
                              context,
                              data[index],
                              data[index].imageUrls[0],
                              data[index].address,
                              data[index].foodType,
                              data[index].mealType,
                              data[index].qty,
                              data[index].hrs,
                              data[index].toAddress);
                        },
                        leading: Image.network(data[index].imageUrls[0]),
                        title: Text('Donation' + (index + 1).toString()),
                        subtitle: Text(
                          "Tap to View",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
