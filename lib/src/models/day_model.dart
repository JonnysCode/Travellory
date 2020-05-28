import 'package:flutter/material.dart';
import 'package:travellory/src/models/schedule_entry.dart';

class Day {
  Day({
    @required this.date,
    this.entries
  }){
    isExpanded = true;
    entries = <ScheduleEntry>[];
  }

  DateTime date;
  List<ScheduleEntry> entries;
  bool isExpanded;

  void toggleExpanded(){
    isExpanded = !isExpanded;
  }

  bool isInBetween(DateTime startDate, DateTime endDate) =>
      date.compareTo(startDate) >= 0
      && date.compareTo(endDate) <= 0;
}