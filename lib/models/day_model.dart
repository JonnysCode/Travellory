import 'package:flutter/cupertino.dart';
import 'package:travellory/utils/date_converter.dart';

import 'booking_model.dart';

class Day {
  Day({
    @required this.date,
    this.bookings,
  }){
    dateString = DateConverter.toDateStringFrom(date);
  }

  DateTime date;
  String dateString;
  List<Booking> bookings;
}