import 'package:intl/intl.dart';

DateTime getDateTimeFrom(String date) {
  if (date == null || date.length < 10) return null;
  if (date.substring(2, 3) == "-") {
    return DateFormat('dd-MM-yyyy', 'en_US').parse(date);
  } else {
    return DateFormat('yyyy-MM-dd').parse(date);
  }
}

String dMMMyyyy(DateTime date) {
  return DateFormat('d MMM yyyy').format(date);
}

String getOnlyDate(String date) {
  final List<String> dateTime = date.split("T");
  return dateTime[0];
}

String yyyyMMdd(String date) {
  final array = date.split("-");
  final newOrder = '${array[2]}-${array[1]}-${array[0]}';
  return newOrder;
}
