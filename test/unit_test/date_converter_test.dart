import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/utils/date_converter.dart';

void main(){
  test('dateTime gets converted to the right String', () {
    final DateTime date1 = DateTime(2020, 1, 1);
    final result1 = DateConverter.format(date1);

    final DateTime date2 = DateTime(2020, 2, 29);
    final result2 = DateConverter.format(date2);

    final DateTime date3 = DateTime(2020, 3, 4);
    final result3 = DateConverter.format(date3);

    final DateTime date4 = DateTime(2020, 4, 8);
    final result4 = DateConverter.format(date4);

    final DateTime date5 = DateTime(2020, 5, 12);
    final result5 = DateConverter.format(date5);

    final DateTime date6 = DateTime(2020, 6, 16);
    final result6 = DateConverter.format(date6);

    final DateTime date7 = DateTime(2020, 7, 20);
    final result7 = DateConverter.format(date7);

    final DateTime date8 = DateTime(2020, 8, 24);
    final result8 = DateConverter.format(date8);

    final DateTime date9 = DateTime(2020, 9, 28);
    final result9 = DateConverter.format(date9);

    final DateTime date10 = DateTime(2020, 10, 11);
    final result10 = DateConverter.format(date10);

    final DateTime date11 = DateTime(2021, 11, 7);
    final result11 = DateConverter.format(date11);

    final DateTime date12 = DateTime(2020, 12, 31);
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
}