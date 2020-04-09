import 'package:flutter/material.dart';
import 'package:travellory/utils/date_converter.dart';


class Day {
  Day({
    @required this.date,
  }){
    dateString = toDateStringFrom(date);
  }

  DateTime date;
  String dateString;
}