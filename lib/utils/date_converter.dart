import 'package:intl/intl.dart';

String toDateStringFrom(DateTime dateTime){
  return dateTime.toString().substring(0, 10);
}

DateTime getDateTimeFrom(String date){
  if(date == null || date.length < 10) return null;
  if(date.substring(2, 3) == "-"){
    return DateFormat('dd-MM-yyyy', 'en_US').parse(date);
  } else {
    return DateFormat('yyyy-MM-dd').parse(date);
  }
}

final List<String> monthsShortened = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
];

String toShortenedMonthDateFrom(String date){
  final List<String> dateItems = date.split("-");
  final String day = dateItems[2];

  final StringBuffer dateBuffer = StringBuffer()
    ..write(day.startsWith('0') ? day.substring(1) : day)
    ..write(' ')
    ..write(monthsShortened[int.parse(dateItems[1])-1])
    ..write(' ')
    ..write(dateItems[0]);

  return dateBuffer.toString();
}

String getOnlyDate(String date) {
  final List<String> dateTime = date.split("T");
  return dateTime[0];
}
