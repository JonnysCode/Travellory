
class DateConverter{
  static final List<String> monthsShortened = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'June', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  static String format(String date){
    StringBuffer dateBuffer = StringBuffer();
    List<String> dateItems = date.split("-");
    dateBuffer.write(dateItems[2]);
    dateBuffer.write(' ');
    dateBuffer.write(monthsShortened[int.parse(dateItems[1])]);
    dateBuffer.write(' ');
    dateBuffer.write(dateItems[0]);
    return dateBuffer.toString();
  }
}