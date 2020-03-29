
class DateConverter{
  static final List<String> monthsShortened = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  static String toShortenedMonthString(DateTime date){
    StringBuffer dateBuffer = StringBuffer();
    dateBuffer.write(date.day);
    dateBuffer.write(' ');
    dateBuffer.write(monthsShortened[date.month-1]);
    dateBuffer.write(' ');
    dateBuffer.write(date.year);
    return dateBuffer.toString();
  }
}