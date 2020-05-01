import 'package:flutter/material.dart';
import 'package:travellory/utils/date_converter.dart';

import 'abstract_model.dart';


class Day {
  Day({
    @required this.date,
    this.bookings
  }){
    dateString = toDateStringFrom(date);
    isExpanded = true;
    bookings = <Model>[];
  }

  DateTime date;
  String dateString;
  List<Model> bookings;
  bool isExpanded;

  void toggleExpanded(){
    isExpanded = !isExpanded;
  }

  bool isInBetween(DateTime startDate, DateTime endDate) =>
      date.compareTo(startDate) >= 0
      && date.compareTo(endDate) <= 0;
}