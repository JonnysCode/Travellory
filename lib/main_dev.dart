import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'myapp.dart';

void main(){
  // to connect to locally running functions
  CloudFunctions.instance.useFunctionsEmulator(origin: "http://10.0.2.2:5001");
  runApp(MyApp());
}

