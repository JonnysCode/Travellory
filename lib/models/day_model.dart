
import 'package:flutter/cupertino.dart';
import 'package:travellory/utils/date_converter.dart';

class Day {
  Day({
    @required this.date,
    this.dateString,
  }){
    dateString = DateConverter.toDateStringFrom(date);
  }

  DateTime date;
  String dateString;
}