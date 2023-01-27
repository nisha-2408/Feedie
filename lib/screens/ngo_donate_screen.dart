import 'package:feedie/providers/ngo_food_request.dart';
import 'package:feedie/widgets/displayNgo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NGODonate extends StatelessWidget {
  static const routeName = 'donate-ngo';
  const NGODonate({super.key});

  @override
  Widget build(BuildContext context) {
    final data = Provider.of<NGORequest>(context);
    return Scaffold(
        appBar: AppBar(title: Text('NGO')),
        body: data.unFulFill.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return DisplayNGO(data: data.unFulFill[index]);
                },
                itemCount: data.unFulFill.length,
              )
            : Center(
                child: Text("No requests as of now!"),
              ));
  }
}
