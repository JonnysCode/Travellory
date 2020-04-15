import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:travellory/service_locator.dart';
import 'myapp.dart';

void main() {
  Logger.level = Level.info;
  setupLocator();
  runApp(MyApp());
}
