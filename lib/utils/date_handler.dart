import 'package:intl/intl.dart';

DateTime getDateTimeFrom(String date){
  if(date == null || date.length < 10) return null;
  if(date.substring(2, 3) == "-"){
    return DateFormat('dd-MM-yyyy', 'en_US').parse(date);
  } else {
    return DateFormat('yyyy-MM-dd').parse(date);
  }
}

String dMMMyyyy(DateTime date){
  return DateFormat('d MMM yyyy').format(date);
}

String getOnlyDate(String date) {
  final List<String> dateTime = date.split("T");
  return dateTime[0];
}

bool isInTimeFrame(DateTime startDateTest, DateTime endDateTest, DateTime startDate, DateTime endDate){
  return startDateTest.compareTo(startDate) >= 0
      && endDateTest.compareTo(endDate) <= 0;
}