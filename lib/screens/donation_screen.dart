// ignore_for_file: avoid_print, prefer_const_constructors, body_might_complete_normally_nullable, non_constant_identifier_names, unused_field, unused_local_variable

import 'package:feedie/models/food_request.dart';
import 'package:feedie/models/screen_arguments.dart';
import 'package:feedie/providers/food_request_process.dart';
import 'package:flutter/material.dart';
import 'package:feedie/widgets/image_input.dart';
import 'package:provider/provider.dart';

// ignore: constant_identifier_names
enum ProductTypeEnum { Veg, NonVeg }

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});
  static const routeName = '/donation-form';

  @override
  State<DonationScreen> createState() => _DonationScreenState();
}

class _DonationScreenState extends State<DonationScreen> {
  ProductTypeEnum? _productTypeEnum;
  //final _productSizeList = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  //String? _selectedVal = "Breakfast";
  String? valueChoose;
  //List listItem = ["Breakfast", "Lunch", "Snacks", "Dinner"];
  double value = 100;
  double values = 12;
  int selected = 0;
  int select = 0;
  List<String> _pickedImage = [];
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

  void _selectImage(List<String> pickedImage) {
    _pickedImage = pickedImage;
    print(_pickedImage);
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

  var types = ['Veg', 'NonVeg'];
  var meal = ['BreakFast', 'Lunch', 'Dinner'];

  void submitData(String toAddr, bool isNgo, String id, int qty) async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_pickedImage.isEmpty) {
      return;
    }
    _form.currentState!.save();
    FoodRequest data = FoodRequest(
        foodName: food_name,
        address: address,
        foodType: types[selected - 1],
        mealType: meal[select - 1],
        qty: value.toInt(),
        hrs: values.toInt(),
        imageUrls: _pickedImage,
        toAddress: toAddr,
        userId: '');
    await Provider.of<FoodRequestProcess>(context, listen: false)
        .addFoodRequest(data, isNgo, id, qty)
        .then((value) {
      _form.currentState!.reset();
      Navigator.of(context).pop();
    });
  }

  final _form = GlobalKey<FormState>();
  String food_name = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
    final toAddr =
        ModalRoute.of(context)!.settings.arguments as ScreenArgumnets;
    print(toAddr);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              TextFormField(
                /* onChanged: (val) {
                  _updateText(val);
                },*/
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 8.0,
                  ),
                  labelText: 'Name of the food',
                  // prefixIcon: Icon(Icons.verified_user_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == '') {
                    return "Please enter a food name";
                  }
                },
                onSaved: (newValue) {
                  food_name = newValue!;
                },
              ),
              SizedBox(height: 15),
              TextFormField(
                /* onChanged: (val) {
                  _updateText(val);
                },*/
                decoration: InputDecoration(
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 8.0,
                  ),
                  labelText: 'Address',
                  // prefixIcon: Icon(Icons.verified_user_outlined),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == '') {
                    return "Please enter address";
                  }
                },
                onSaved: (newValue) {
                  address = newValue!;
                },
              ),
              SizedBox(height: 10),
              Text(
                "Select the type of the food",
                style: TextStyle(color: Colors.black),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  customRadio("Veg", 1),
                  SizedBox(width: 5),
                  customRadio("NonVeg", 2)
                ],
              ),
              SizedBox(height: 5),
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
              SizedBox(height: 20),
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
              SizedBox(height: 10),
              Text(
                "When was the food prepared(hrs)",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              Slider(
                value: values,
                min: 0,
                max: 12,
                divisions: 12,
                activeColor: Colors.orange,
                label: values.round().toString(),
                onChanged: (values) => setState(() => this.values = values),
              ),
              SizedBox(height: 10),
              Text(
                "Add photos of the food",
                style: TextStyle(
                  color: Colors.black,
                  //fontWeight: FontWeight.w500,
                  //fontSize: 15,
                ),
              ),
              SizedBox(height: 7),
              ImageInput(_selectImage),
              SizedBox(height: 5),
              OutlinedButton(
                onPressed: () => submitData(
                    toAddr.address, toAddr.isNGO, toAddr.id, toAddr.qty),
                style:
                    OutlinedButton.styleFrom(minimumSize: const Size(200, 50)),
                child: Text(
                  "Submit Form".toUpperCase(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
