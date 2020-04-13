import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travellory/widgets/image_picker_dialog.dart';

class ImagePickerHandler extends StatelessWidget {
  ImagePickerDialog imagePicker;
  AnimationController _controller;
  ImagePickerListener _listener;
  BuildContext context;

  ImagePickerHandler(this._listener, this._controller);

  openCamera() async {
    imagePicker.dismissDialog();
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    await cropImage(image);
  }

  openGallery() async {
    image();
    //imagePicker.dismissDialog();
    //final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    //await cropImage(image);
  }

  void init() {
    imagePicker = ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  Future cropImage(File image) async {
    File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );
    _listener.userImage(croppedFile);
  }

  showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }

  Widget image() {
    print('Here i am');
    return Container(key: Key('croped_Image'));
  }

  @override
  Widget build(BuildContext context) {}
}

abstract class ImagePickerListener {
  userImage(File _image);
}
