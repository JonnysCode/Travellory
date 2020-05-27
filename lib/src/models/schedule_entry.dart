import 'package:flutter/cupertino.dart';
import 'abstract_model.dart';

class ScheduleEntry{
  ScheduleEntry({
    @required this.booking,
    @required this.dayType
  });

  Model booking;
  DayType dayType;
}

enum DayType{
  first, middle, last, single
}

DayType getDayType(DateTime day, DateTime startDate, DateTime endDate){
  if(day.compareTo(startDate) == 0){
    return day.compareTo(endDate) == 0 ? DayType.single : DayType.first;
  }
  else if(day.compareTo(endDate) == 0){
    return day.compareTo(startDate) == 0 ? DayType.single : DayType.last;
  }
  else if(day.compareTo(endDate) < 0 && day.compareTo(startDate) > 0){
    return DayType.middle;
  }
  return null;
}