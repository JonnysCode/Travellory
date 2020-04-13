

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
