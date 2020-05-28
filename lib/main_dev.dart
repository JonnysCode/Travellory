import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'src/myapp.dart';

void main(){
  // to connect to locally running functions
  Logger.level = Level.debug;
  CloudFunctions.instance.useFunctionsEmulator(origin: 'http://10.0.2.2:5001'); // http://localhost:5001 for osx!
  runApp(MyApp());
}

