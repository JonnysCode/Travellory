import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'myapp.dart';

void main() {
  Logger.level = Level.debug;
  runApp(MyApp());
}
