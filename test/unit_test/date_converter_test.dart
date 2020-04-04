import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/date_converter.dart';

void main(){
  test('yyyy-mm-dd String gets converted to a String (d)d mmm yyyy', () {
    final String date1 = '2020-01-01';
    final result1 = DateConverter.format(date1);

    final String date2 = '2020-02-29';
    final result2 = DateConverter.format(date2);

    final String date3 = '2020-03-04';
    final result3 = DateConverter.format(date3);

    final String date4 = '2020-04-08';
    final result4 = DateConverter.format(date4);

    final String date5 = '2020-05-12';
    final result5 = DateConverter.format(date5);

    final String date6 = '2020-06-16';
    final result6 = DateConverter.format(date6);

    final String date7 = '2020-07-20';
    final result7 = DateConverter.format(date7);

    final String date8 = '2020-08-24';
    final result8 = DateConverter.format(date8);

    final String date9 = '2020-09-28';
    final result9 = DateConverter.format(date9);

    final String date10 = '2020-10-11';
    final result10 = DateConverter.format(date10);

    final String date11 = '2021-11-07';
    final result11 = DateConverter.format(date11);

    final String date12 = '2020-12-31';
    final result12 = DateConverter.format(date12);

    expect(result1, '1 Jan 2020');
    expect(result2, '29 Feb 2020');
    expect(result3, '4 Mar 2020');
    expect(result4, '8 Apr 2020');
    expect(result5, '12 May 2020');
    expect(result6, '16 June 2020');
    expect(result7, '20 Jul 2020');
    expect(result8, '24 Aug 2020');
    expect(result9, '28 Sep 2020');
    expect(result10, '11 Oct 2020');
    expect(result11, '7 Nov 2021');
    expect(result12, '31 Dec 2020');
  });

  test('dateTime gets converted to a String yyyy-mm-dd', () {
    final DateTime dateTime1 = DateTime(2020, 8, 5);
    final dateString1 = DateConverter.toDateStringFrom(dateTime1);

    final DateTime dateTime2 = DateTime(2020, 12, 1);
    final dateString2 = DateConverter.toDateStringFrom(dateTime2);

    final DateTime dateTime3 = DateTime(2020, 1, 31);
    final dateString3 = DateConverter.toDateStringFrom(dateTime3);

    expect(dateString1, '2020-08-05');
    expect(dateString2, '2020-12-01');
    expect(dateString3, '2020-01-31');
  });
}