import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travellory/widgets/image_picker_dialog.dart';

class ImagePickerHandler {
  ImagePickerHandler(this._listener, this._controller);

  ImagePickerDialog imagePicker;
  final AnimationController _controller;
  final ImagePickerListener _listener;

  void openCamera() async {
    imagePicker.dismissDialog();
    final image = await ImagePicker.pickImage(source: ImageSource.camera);
    await cropImage(image);
  }

  void openGallery() async {
    imagePicker.dismissDialog();
    final image = await ImagePicker.pickImage(source: ImageSource.gallery);
    await cropImage(image);
  }

  void init() {
    imagePicker = ImagePickerDialog(this, _controller);
    imagePicker.initState();
  }

  Future cropImage(File image) async {
    final File croppedFile = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
      maxWidth: 512,
      maxHeight: 512,
    );
    _listener.userImage(croppedFile);
  }

  void showDialog(BuildContext context) {
    imagePicker.getImage(context);
  }
}

abstract class ImagePickerListener {
  void userImage(File _image);
}
