
class DateConverter{
  static final List<String> monthsShortened = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  static String format(String date){
    StringBuffer dateBuffer = StringBuffer();
    List<String> dateItems = date.split("-");
    String day = dateItems[2];
    dateBuffer.write(day.startsWith('0') ? day.substring(1) : day);
    dateBuffer.write(' ');
    dateBuffer.write(monthsShortened[int.parse(dateItems[1])-1]);
    dateBuffer.write(' ');
    dateBuffer.write(dateItems[0]);

    return dateBuffer.toString();
  }

  static String toDateStringFrom(DateTime dateTime){
    return dateTime.toString().substring(0, 10);
  }

  static DateTime getDateTimeFrom(String date){
    List<String> dates = date.split('-');
    return DateTime(int.parse(dates[0]), int.parse(dates[1]), int.parse(dates[2]));
  }
}