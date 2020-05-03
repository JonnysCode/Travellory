import 'package:flutter/material.dart';

import 'abstract_model.dart';


class Day {
  Day({
    @required this.date,
    this.bookings
  }){
    isExpanded = true;
    bookings = <Model>[];
  }

  DateTime date;
  List<Model> bookings;
  bool isExpanded;

  void toggleExpanded(){
    isExpanded = !isExpanded;
  }

  bool isInBetween(DateTime startDate, DateTime endDate) =>
      date.compareTo(startDate) >= 0
      && date.compareTo(endDate) <= 0;
}