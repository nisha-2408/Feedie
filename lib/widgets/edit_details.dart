import 'package:feedie/providers/user_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class EditDetails extends StatefulWidget {
  final bool isEmail;
  final String email;
  const EditDetails({required this.isEmail, required this.email});

  @override
  State<EditDetails> createState() => _EditDetailsState();
}

class _EditDetailsState extends State<EditDetails> {
  final _form = GlobalKey<FormState>();
  String det = "";

  Future<void> submitData() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    await Provider.of<UserData>(context, listen: false)
        .setUserDetails(det, widget.isEmail)
        .then((value) {

      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
          child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                widget.isEmail ? 'Edit Email' : 'Edit Phone Number',
                style: TextStyle(fontSize: 25),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    initialValue: widget.email,
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 8.0,
                      ),
                      hintStyle: Theme.of(context).textTheme.bodyText1,
                      hintText: widget.isEmail ? 'Email' : 'Phone Number',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onSaved: (newValue) => det = newValue!,
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 60,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                        onPressed: submitData,
                        child: Text(
                          "Submit",
                          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        )),
                  ),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
