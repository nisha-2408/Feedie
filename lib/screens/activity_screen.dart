// ignore_for_file: prefer_const_constructors, prefer_const_declarations, avoid_unnecessary_containers, unused_local_variable

import 'package:feedie/models/food_request.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
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
                    height: 150,
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
                    child: ListTile(
                      onTap: () {
                        Fluttertoast.showToast(
                            msg: "Status: ${data[index].status!}",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 2,
                            backgroundColor: Colors.orange,
                            textColor: Colors.white,
                            fontSize: 15);
                      },
                      leading: Image(image: NetworkImage(data[index].imageUrls[0]),),
                      title: Text('Donation ${index+1}'),
                      subtitle: Column(
                        children: [
                          Text("Address: ${data[index].address}", style: TextStyle(color: Colors.blueGrey),),
                          Text("Food Type: ${data[index].foodType}", style: TextStyle(color: Colors.blueGrey),),
                          Text("Meal Type: ${data[index].mealType}", style: TextStyle(color: Colors.blueGrey),),
                          Text("Quantity: ${data[index].qty}", style: TextStyle(color: Colors.blueGrey),),
                          Text("Time: ${data[index].hrs} hrs ago", style: TextStyle(color: Colors.blueGrey),),
                          Text("To Address: ${data[index].toAddress} hrs ago", style: TextStyle(color: Colors.blueGrey),),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          );
  }
}
