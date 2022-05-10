import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

late PickedFile _picture;

Future<PickedFile> openGallery(BuildContext context) async {
  _picture = (await ImagePicker().getImage(source: ImageSource.gallery))!;
  Navigator.of(context).pop();
  return _picture;
}

Future<PickedFile> openCamera(BuildContext context) async {
  _picture = (await ImagePicker().getImage(source: ImageSource.camera))!;
  Navigator.of(context).pop();
  return _picture;
}
