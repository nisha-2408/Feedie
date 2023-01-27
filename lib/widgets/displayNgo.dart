import 'package:feedie/models/request.dart';
import 'package:feedie/models/screen_arguments.dart';
import 'package:feedie/screens/donation_screen.dart';
import 'package:flutter/material.dart';

class DisplayNGO extends StatefulWidget {
  final Request data;
  const DisplayNGO({super.key, required this.data});

  @override
  State<DisplayNGO> createState() => _DisplayNGOState();
}

class _DisplayNGOState extends State<DisplayNGO> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.data.ngoName,
                style: TextStyle(
                    color: Color.fromARGB(255, 42, 42, 42),
                    fontWeight: FontWeight.w500,
                    fontSize: 20),
              ),
              SizedBox(
                height: 8,
              ),
              Text("Address: " + widget.data.address,
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 145, 145),
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              SizedBox(
                height: 8,
              ),
              Text( 'Population: '+ widget.data.remaining.toString(),
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 145, 145),
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              SizedBox(
                height: 8,
              ),
              Text("Meal Type: " + widget.data.mealType,
                  style: TextStyle(
                      color: Color.fromARGB(255, 146, 145, 145),
                      fontWeight: FontWeight.w400,
                      fontSize: 15)),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(DonationScreen.routeName,
                        arguments: ScreenArgumnets(address: widget.data.address, isNGO: true, id: widget.data.id, qty: widget.data.remaining) );
                  },
                  child: Text('Donate'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
