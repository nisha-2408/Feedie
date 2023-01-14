// ignore_for_file: prefer_const_constructors, constant_identifier_names

//import 'dart:html';

import 'package:flutter/material.dart';
//import 'package:feedie/widgets/image_input.dart';

enum ProductTypeEnum { Veg, NonVeg }

class NGOFoodRequest extends StatefulWidget {
  static const routeName = '/ngo-request';
  const NGOFoodRequest({super.key});

  @override
  State<NGOFoodRequest> createState() => _NGOFoodRequestState();
}

class _NGOFoodRequestState extends State<NGOFoodRequest> {
  //final _productSizeList = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  //String? _selectedVal = "Breakfast";
  String? valueChoose;
  //List listItem = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  double value = 100;
  double values = 12;
  DateTime? _dateTime;
  int selected = 0;
  int select = 0;
  String? selectedValue;
  Widget customRadio(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selected = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (selected == index) ? Colors.orange : Colors.grey,
        ),
      ),
      /* shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide: BorderSide(
        color: (selected == index) ? Colors.green : Colors.blueGrey,
      ),*/
    );
  }

  Widget customRadios(String text, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          select = index;
        });
      },
      child: Text(
        text,
        style: TextStyle(
          color: (select == index) ? Colors.orange : Colors.grey,
        ),
      ),
      /* shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      borderSide: BorderSide(
        color: (selected == index) ? Colors.green : Colors.blueGrey,
      ),*/
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Request Food"),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text(
              "Meal Type",
              style: TextStyle(color: Colors.black),
            ),
            Row(
              children: [
                customRadios("Breakfast", 1),
                SizedBox(width: 5),
                customRadios("Lunch", 2),
                SizedBox(width: 5),
                customRadios("Dinner", 3),
              ],
            ),
            SizedBox(height: 10),
            Text(
              "Meal Quantity(Person)",
              style: TextStyle(color: Colors.black),
            ),
            Slider(
              value: value,
              min: 0,
              max: 100,
              divisions: 20,
              activeColor: Colors.orange,
              label: value.round().toString(),
              onChanged: (value) => setState(() => this.value = value),
            ),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                showDatePicker(
                  context: context,
                  
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2023),
                  lastDate: DateTime(2222),
                ).then(
                  (date) {
                    setState(
                      () {
                        _dateTime = date!;
                      },
                    );
                  },
                );
              },
              child: Text('Pick a date'),
            ),
            Text(_dateTime == null
                ? 'Nothing has been picked yet'
                : "Date: ${_dateTime!.toIso8601String().split("T")[0]}"),
            SizedBox(height: 10),
            OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
              child: Text(
                "Submit Form".toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
