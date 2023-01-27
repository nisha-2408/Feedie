import 'package:feedie/providers/food_request_process.dart';
import 'package:feedie/widgets/accept_orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoodAcepted extends StatefulWidget {
  const FoodAcepted({super.key});
  static const routeName = '/accepted-orders';

  @override
  State<FoodAcepted> createState() => _FoodAceptedState();
}

class _FoodAceptedState extends State<FoodAcepted> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      Provider.of<FoodRequestProcess>(context).getAccepted().then((value) {
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
    final data = Provider.of<FoodRequestProcess>(context).requestDatas;
    return Scaffold(
        appBar: AppBar(title: Text('Accepted Orders')),
        // ignore: prefer_const_constructors
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.isNotEmpty
                ? ListView.builder(
                    itemBuilder: (context, index) {
                      return AcceptData(item: data[index]);
                    },
                    itemCount: data.length,
                  )
                // ignore: prefer_const_constructors
                : Center(
                    child: Text("No accepted requests added yet! "),
                  ));
    ;
  }
}
