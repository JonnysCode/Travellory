import 'package:flutter/material.dart';

class MyControllerWrapper {
  String text;
  final TextEditingController controller = TextEditingController();
  MyControllerWrapper(String text) {
    this.text = text;
  }
}