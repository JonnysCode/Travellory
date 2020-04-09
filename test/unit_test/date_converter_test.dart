import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/date_converter.dart';

void main(){
  test('dateTime gets converted to the right String', () {
    final String date1 = '2020-01-01';
    final result1 = toShortenedMonthDateFrom(date1);

    final String date2 = '2020-02-29';
    final result2 = toShortenedMonthDateFrom(date2);

    final String date3 = '2020-03-04';
    final result3 = toShortenedMonthDateFrom(date3);

    final String date4 = '2020-04-08';
    final result4 = toShortenedMonthDateFrom(date4);

    final String date5 = '2020-05-12';
    final result5 = toShortenedMonthDateFrom(date5);

    final String date6 = '2020-06-16';
    final result6 = toShortenedMonthDateFrom(date6);

    final String date7 = '2020-07-20';
    final result7 = toShortenedMonthDateFrom(date7);

    final String date8 = '2020-08-24';
    final result8 = toShortenedMonthDateFrom(date8);

    final String date9 = '2020-09-28';
    final result9 = toShortenedMonthDateFrom(date9);

    final String date10 = '2020-10-11';
    final result10 = toShortenedMonthDateFrom(date10);

    final String date11 = '2021-11-07';
    final result11 = toShortenedMonthDateFrom(date11);

    final String date12 = '2020-12-31';
    final result12 = toShortenedMonthDateFrom(date12);

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
}