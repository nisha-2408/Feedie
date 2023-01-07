// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, empty_statements, dead_code

import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/widgets/hunger_spot_itm.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});
  static const routeName = '/admin';

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  var isInit = true;
  var isLoading = false;
  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      Provider.of<HungerSpot>(
        context,
      ).getHungerSpot().then((value) {
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
    final data = Provider.of<HungerSpot>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Admin')),
        // ignore: prefer_const_constructors
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : data.hungerData.isNotEmpty ? ListView.builder(
                itemBuilder: (context, index) {
                  return HungerSpotItem(item: data.hungerData[index]);
                },
                itemCount: data.hungerData.length,
              ) : Column(
                children: [
                  Center(child: Text("No requests as of now!"),),
                  Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 150,
                        height: 60,
                        child: ElevatedButton.icon(
                            icon: Icon(Icons.logout),
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ))),
                            onPressed: () {
                              Provider.of<Auth>(context, listen: false)
                                  .logOut();
                            },
                            label: Text(
                              "Logout",
                              style: TextStyle(
                                  fontSize: 18, fontFamily: 'Poppins'),
                            )),
                      ),
                    )
                ],
              )
              );
    ;
  }
}
