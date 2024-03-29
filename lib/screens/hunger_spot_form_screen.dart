// ignore_for_file: unused_import, prefer_const_constructors, unnecessary_import, implementation_imports, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, sort_child_properties_last, sized_box_for_whitespace, avoid_print, use_key_in_widget_constructors, unused_local_variable
import 'dart:io';
import 'package:feedie/models/hunger_spot_data.dart';
import 'package:feedie/providers/hunger_spot.dart';
import 'package:feedie/screens/hunger_spot_screen.dart';
import 'package:feedie/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:regexed_validator/regexed_validator.dart';

class HungerSpotForm extends StatefulWidget {
  final String? address;
  const HungerSpotForm({this.address});
  static const routeName = '/add-hunger/spot';

  @override
  State<HungerSpotForm> createState() => _HungerSpotFormState();
}

class _HungerSpotFormState extends State<HungerSpotForm> {
  String address = "";
  String? selectedValue;
  List<String> _pickedImage = [];
  int people = 20;
  bool criteria = false;
  final _form = GlobalKey<FormState>();

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    if (widget.address != null) {
      address = widget.address!;
    }
    super.initState();
  }

  void _selectImage(List<String> pickedImage) {
    _pickedImage = pickedImage;
    //print(_pickedImage);
  }

  void _showDialog(String message, bool isSuccess) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 40, vertical: 200),
        content: Container(
          child: Column(
            children: [
              Image(
                  image: AssetImage(
                    'assets/images/tick.png',
                  ),
                  width: 200,
                  height: 200),
              Text('Your request has been sent to admin for approval!')
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/home', (Route<dynamic> route) => false);
            },
          )
        ],
      ),
    );
  }

  void _saveForm() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    if (_pickedImage.isEmpty) {
      return;
    }
    _form.currentState!.save();
    HungerSpotData data = HungerSpotData(
        images: _pickedImage,
        address: address,
        population: people,
        now: DateTime.now(),
        hungerSpotName: selectedValue!);
    print(data);
    try {
      await Provider.of<HungerSpot>(context, listen: false)
          .addHungerSpot(data)
          .then((value) {
        _showDialog('', true);
      });
    } catch (error) {
      print(error);
    }
    _form.currentState!.reset();
    //print(address);
    //print(_pickedImage);
    //print(people);
    //print(selectedValue);
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(child: Text("Slum Area"), value: "Slum Area"),
      DropdownMenuItem(child: Text("Road Side"), value: "Road Side"),
      DropdownMenuItem(child: Text("Railway Side"), value: "Railway Side"),
    ];
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    address = args;
    return Scaffold(
      appBar: AppBar(title: Text('Hunger Spot')),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: Form(
            key: _form,
            child: Column(
              children: [
                TextFormField(
                  initialValue: args,
                  decoration: InputDecoration(
                    errorStyle: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 8.0,
                    ),
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    hintText: 'Address',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) =>
                      value == null ? 'Please enter address!' : null,
                  onSaved: ((newValue) {
                    address = newValue!;
                  }),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              'Hunger Spot Name',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 42, 42, 42),
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            DropdownButtonFormField(
                                validator: (value) => value == null
                                    ? 'Please select an option'
                                    : null,
                                decoration: InputDecoration(
                                  errorStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 8.0,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.orange, width: 2),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  filled: true,
                                  fillColor: Colors.orange,
                                ),
                                dropdownColor: Colors.orange,
                                value: selectedValue,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                onChanged: (value) {
                                  selectedValue = value;
                                },
                                items: dropdownItems)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Divider(),
                Container(
                  child: Column(
                    children: [
                      Text(
                        "Add photos of the spot",
                        style: TextStyle(
                            color: Color.fromARGB(255, 42, 42, 42),
                            fontWeight: FontWeight.w500,
                            fontSize: 15),
                      ),
                      ImageInput(_selectImage),
                    ],
                  ),
                ),
                Divider(),
                Column(
                  children: [
                    Text(
                      'Population',
                      style: TextStyle(
                          color: Color.fromARGB(255, 42, 42, 42),
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    ),
                    Slider(
                        label: 'Population',
                        value: people.toDouble(),
                        onChanged: (value) {
                          setState(() {
                            people = value.toInt();
                          });
                        },
                        min: 10,
                        max: 50),
                    Text(people.toString(),
                        style: TextStyle(
                            color: Color.fromARGB(255, 146, 145, 145),
                            fontWeight: FontWeight.w400,
                            fontSize: 15))
                  ],
                ),
                Divider(),
                Row(
                  children: [
                    Checkbox(
                      value: criteria,
                      onChanged: (value) {
                        setState(() {
                          criteria = value!;
                        });
                      },
                      activeColor: Colors.white,
                      checkColor: Theme.of(context).colorScheme.primary,
                    ),
                    Text('Above mentioned information is legit.',
                        style: TextStyle(color: Colors.grey))
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                      style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ))),
                      onPressed: !criteria ? null : _saveForm,
                      child: Text(
                        "Add Hunger Spot",
                        style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
