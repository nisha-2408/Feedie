// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, use_build_context_synchronously, unused_local_variable, depend_on_referenced_packages
import 'dart:io';
import 'package:feedie/providers/auth.dart';
import 'package:feedie/providers/user_data.dart';
import 'package:feedie/widgets/edit_details.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:regexed_validator/regexed_validator.dart';
import 'package:path_provider/path_provider.dart' as syspaths;

class NGOProfile extends StatefulWidget {
  const NGOProfile({super.key});

  @override
  State<NGOProfile> createState() => _NGOProfileState();
}

class _NGOProfileState extends State<NGOProfile> {
  var isInit = true;
  var isLoading = false;
  Map<String, dynamic> data = {};
  @override
  void didChangeDependencies() {
    // ignore: todo
    // TODO: implement didChangeDependencies
    if (isInit) {
      data = Provider.of<UserData>(context, listen: false).userData;

      //print(data);
    }
    isInit = false;
    super.didChangeDependencies();
  }

  UploadTask? uploadTask;
  void _selectPicture() async {
    final picker = ImagePicker();
    final XFile? imageFile = await picker.pickImage(
        source: ImageSource.gallery, maxWidth: 110, maxHeight: 110);
    final fileName = File(imageFile!.path);
    final paths = 'profile/$fileName';
    final ref = FirebaseStorage.instance.ref().child(paths);
    uploadTask = ref.putFile(fileName);
    final snapShot = await uploadTask!.whenComplete(() => null);
    var done = false;
    final url = await snapShot.ref.getDownloadURL();
    setState(() {
      isLoading = true;
    });
    await Provider.of<UserData>(context, listen: false).setUserImage(url).then(
      (value) {
        setState(() {
          data = Provider.of<UserData>(context, listen: false).userData;
          isLoading = false;
        });
      },
    );
  }

  Future<void> onRefresh(BuildContext context) async {
    setState(() {
      data = Provider.of<UserData>(context, listen: false).userData;
    });
  }

  void startEdit(BuildContext ctx, bool isEmail) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: 250,
            child: EditDetails(isEmail: isEmail, email: data['contact']),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: RefreshIndicator(
          onRefresh: () => onRefresh(context),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(26, 129, 129, 129),
                                      spreadRadius: 3,
                                      blurRadius: 3)
                                ]),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: isLoading ? CircularProgressIndicator() : Image(
                                  image: data['imageUrl'] == ''
                                      ? AssetImage('assets/images/account.png')
                                      : NetworkImage(data['imageUrl'])
                                          as ImageProvider),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            data['name'],
                            style:
                                TextStyle(color: Colors.black54, fontSize: 15),
                          )
                        ],
                      ),
                      ElevatedButton.icon(
                          onPressed: _selectPicture,
                          icon: Icon(Icons.photo_album_rounded),
                          label: Text('Take Picture'))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                            color: Color.fromARGB(255, 224, 224, 224)),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromARGB(255, 194, 194, 194),
                              offset: Offset(0, 10),
                              spreadRadius: 5,
                              blurRadius: 20)
                        ]),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text(
                              'Email: ',
                              style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 62, 62, 62),
                                  overflow: TextOverflow.ellipsis),
                            ),
                            Flexible(
                              child: Text(
                                data['email'],
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromARGB(255, 114, 114, 114),
                                    overflow: TextOverflow.ellipsis),
                              ),
                            )
                          ],
                        ),
                        Divider(),
                        GestureDetector(
                          onTap: () {
                            startEdit(context, false);
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Phone: ',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 62, 62, 62),
                                ),
                              ),
                              Text(
                                data['contact'] == ""
                                    ? "No phone number"
                                    : data['contact'],
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w300,
                                  color: Color.fromARGB(255, 114, 114, 114),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 224, 224, 224)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 194, 194, 194),
                                offset: Offset(0, 10),
                                spreadRadius: 5,
                                blurRadius: 20)
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.food_bank_rounded,
                            color: Colors.blue,
                            size: 40,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Your Requests',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 62, 62, 62),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: Color.fromARGB(255, 224, 224, 224)),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Color.fromARGB(255, 194, 194, 194),
                                offset: Offset(0, 10),
                                spreadRadius: 5,
                                blurRadius: 20)
                          ]),
                      child: Row(
                        children: [
                          Icon(
                            Icons.notifications_active_rounded,
                            color: Colors.blue,
                            size: 40,
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          Text(
                            'Notifications',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 62, 62, 62),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 150,
                    height: 60,
                    child: ElevatedButton.icon(
                        icon: Icon(Icons.logout),
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ))),
                        onPressed: () {
                          Provider.of<Auth>(context, listen: false).logOut();
                        },
                        label: Text(
                          "Logout",
                          style: TextStyle(fontSize: 18, fontFamily: 'Poppins'),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
