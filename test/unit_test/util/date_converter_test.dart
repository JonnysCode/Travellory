import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/date_converter.dart';

void main(){
  test('yyyy-mm-dd String gets converted to a String (d)d mmm yyyy', () {
    final DateTime date1 = DateTime(2020, 1, 1);
    final result1 = dMMMyyyy(date1);

    final DateTime date2 = DateTime(2020, 2, 29);
    final result2 = dMMMyyyy(date2);

    expect(result1, '1 Jan 2020');
    expect(result2, '29 Feb 2020');
  });

  test('String yyyy-mm-dd gets converted to DateTime', () {
    final String date1 = '2020-08-05';
    final DateTime dateTime1 = getDateTimeFrom(date1);

    final String date2 = '2020-12-01';
    final DateTime dateTime2 = getDateTimeFrom(date2);

    final String date3 = '2020-01-31';
    final DateTime dateTime3 = getDateTimeFrom(date3);

    final String date4 = '31-01-2020';
    final DateTime dateTime4 = getDateTimeFrom(date4);


    expect(dateTime1, DateTime(2020, 8, 5));
    expect(dateTime2, DateTime(2020, 12, 1));
    expect(dateTime3, DateTime(2020, 1, 31));
    expect(dateTime4, DateTime(2020, 1, 31));
  });
}