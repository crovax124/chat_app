import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AvatarPicker extends StatefulWidget {
  AvatarPicker(this.imagePickFn);

  final Function(File pickedImage) imagePickFn;

  @override
  _AvatarPickerState createState() => _AvatarPickerState();
}

class _AvatarPickerState extends State<AvatarPicker> {
  File _pickedImage;
  final ImagePicker _picker = ImagePicker();
  String url =
      'https://cdn.pixabay.com/photo/2015/03/04/22/35/head-659652_960_720.png';

  void _pickImage() async {
    var pickedImageFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50, maxWidth: 150,maxHeight: 150);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    widget.imagePickFn(_pickedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          textColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.image),
          label: Text('Avatar Hinzufügen'),
        ),
      ],
    );
  }
}
