// ignore_for_file: unused_import, prefer_const_constructors, duplicate_ignore, unnecessary_import, implementation_imports

import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var isInit = true;
  var isLoading = false;

  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      isLoading = true;
      //print(isLoading);
      Provider.of<UserData>(context).fetchUserData().then((value) {
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
    final _userData = Provider.of<UserData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Feedie"),
      ),
      // ignore: prefer_const_constructors
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(child: Text(_userData.name)),
    );
  }
}
