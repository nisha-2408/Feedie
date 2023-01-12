import 'package:flutter/material.dart';
import 'package:feedie/widgets/image_input.dart';

enum ProductTypeEnum { Veg, NonVeg }

class DonationScreen extends StatefulWidget {
  const DonationScreen({super.key});

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
    //print(_pickedImage);
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

  void submitData() {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    print(food_name);
    print(address);
    print(_pickedImage);
    print(types[selected-1]);
    print(meal[select-1]);
    print(value);
    print(values);
    _form.currentState!.reset();
  }

  final _form = GlobalKey<FormState>();
  String food_name = '';
  String address = '';

  @override
  Widget build(BuildContext context) {
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
                onPressed: submitData,
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
