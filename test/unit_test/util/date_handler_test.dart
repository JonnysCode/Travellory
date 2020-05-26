import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/utils/date_handler.dart';

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

  test('test if daterange is in timeframe', () {
    final DateTime startDate = DateTime(2020, 2, 6);
    final DateTime endDate = DateTime(2020, 2, 10);
    final DateTime beforeStart1 = DateTime(2020, 1, 1);
    final DateTime beforeStart2 = DateTime(2020, 2, 1);
    final DateTime between = DateTime(2020, 2, 8);
    final DateTime afterEnd1 = DateTime(2020, 2, 20);

    final startEndBefore = isInTimeFrame(beforeStart1, beforeStart2, startDate, endDate);
    final startBeforeEndOnStart = isInTimeFrame(beforeStart1, startDate, startDate, endDate);
    final startBeforeEndBetween = isInTimeFrame(beforeStart1, between, startDate, endDate);
    final startBeforeEndOnEnd = isInTimeFrame(beforeStart1, endDate, startDate, endDate);
    final startBeforeEndAfter = isInTimeFrame(beforeStart1, afterEnd1, startDate, endDate);

    final startOnStartBetween = isInTimeFrame(startDate, between, startDate, endDate);
    final startOnStartEndOnEnd = isInTimeFrame(startDate, endDate, startDate, endDate);
    final startOnStartEndAfter = isInTimeFrame(startDate, afterEnd1, startDate, endDate);

    final startBetweenEndBetween = isInTimeFrame(between, between, startDate, endDate);
    final startBetweenEndOnEnd = isInTimeFrame(between, endDate, startDate, endDate);
    final startBetweenEndAfter = isInTimeFrame(between, afterEnd1, startDate, endDate);

    final startOnEndEndAfter = isInTimeFrame(endDate, afterEnd1, startDate, endDate);

    expect(startEndBefore, false);
    expect(startBeforeEndOnStart, false);
    expect(startBeforeEndBetween, false);
    expect(startBeforeEndOnEnd, false);
    expect(startBeforeEndAfter, false);

    expect(startOnStartBetween, true);
    expect(startOnStartEndOnEnd, true);
    expect(startOnStartEndAfter, false);

    expect(startBetweenEndBetween, true);
    expect(startBetweenEndOnEnd, true);
    expect(startBetweenEndAfter, false);

    expect(startOnEndEndAfter, false);

  });
}