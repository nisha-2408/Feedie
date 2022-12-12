// ignore_for_file: depend_on_referenced_packages, use_key_in_widget_constructors, library_private_types_in_public_api, unused_local_variable, sort_child_properties_last, prefer_const_constructors, prefer_const_constructors_in_immutables, unused_field, prefer_final_fields, avoid_print, prefer_is_not_empty

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

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
    final savedImage = await File(imageFile.path).copy('${appDir.path}/$fileName');
    _savedImages.add(savedImage.path);
    //print(savedImage.path);
    widget.onSelectImage(_savedImages);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        !_storedImages.isEmpty
            ? GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _storedImages.length,
                itemBuilder: (context, index) {
                  return Image.file(
                    _storedImages[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
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
