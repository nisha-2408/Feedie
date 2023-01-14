// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable, sort_child_properties_last, prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, prefer_final_fields, avoid_print, prefer_is_not_empty, unnecessary_brace_in_string_interps, sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;
import 'package:firebase_storage/firebase_storage.dart';

class ImageInput extends StatefulWidget {
  final Function onSelectImage;
  ImageInput(this.onSelectImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  List<File> _storedImages = [];
  List<String> _savedImages = [];
  UploadTask? uploadTask;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final XFile? imageFile =
        await picker.pickImage(source: ImageSource.camera, maxWidth: 600);
    setState(() {
      _storedImage = File(imageFile!.path);
      _storedImages.add(_storedImage!);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile!.path);
    final savedImage =
        await File(imageFile.path).copy('${appDir.path}/$fileName');
    final paths = 'hunger-spot/${fileName}';
    final pickedFile = File(imageFile.path);
    final ref = FirebaseStorage.instance.ref().child(paths);
    uploadTask = ref.putFile(pickedFile);
    final snapShot = await uploadTask!.whenComplete(() => null);
    var done = false;
    final url = await snapShot.ref.getDownloadURL();
    print(url);
    _savedImages.add(url);
    print(_savedImages);
    widget.onSelectImage(_savedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        !_storedImages.isEmpty
            ? Container(
                height: 250,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _storedImages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.file(
                        _storedImages[index],
                        fit: BoxFit.cover,
                        width: 150,
                      ),
                    );
                  },
                ),
              )
            : Text('No Image Taken'),
        SizedBox(
          width: 10,
        ),
        TextButton.icon(
          icon: Icon(Icons.camera),
          label: Text(
            'Take Picture',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
          onPressed: _takePicture,
        ),
      ],
    );
  }
}
