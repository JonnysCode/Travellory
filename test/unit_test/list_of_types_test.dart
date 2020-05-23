import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/forms/dropdown.dart';

void main() {

test('getDropdownBookingType returns correct Item', () {
  Item result;
  Item expected;

  result = getDropdownBookingType('Hotel');
  expected = accommodationTypes[0];
  expect(result, expected);

  result = getDropdownBookingType('Airbnb');
  expected = accommodationTypes[1];
  expect(result, expected);

  result = getDropdownBookingType('Hostel');
  expected = accommodationTypes[2];
  expect(result, expected);

  result = getDropdownBookingType('Motel');
  expected = accommodationTypes[3];
  expect(result, expected);

  result = getDropdownBookingType('Bed & Breakfast');
  expected = accommodationTypes[4];
  expect(result, expected);

  result = getDropdownBookingType('Other Accommodation');
  expected = accommodationTypes[5];
  expect(result, expected);

  result = getDropdownBookingType('Rail');
  expected = publicTransportTypes[0];
  expect(result, expected);

  result = getDropdownBookingType('Bus');
  expected = publicTransportTypes[1];
  expect(result, expected);

  result = getDropdownBookingType('Metro');
  expected = publicTransportTypes[2];
  expect(result, expected);

  result = getDropdownBookingType('Ferry');
  expected = publicTransportTypes[3];
  expect(result, expected);

  result = getDropdownBookingType('Taxi');
  expected = publicTransportTypes[4];
  expect(result, expected);

  result = getDropdownBookingType('Uber');
  expected = publicTransportTypes[5];
  expect(result, expected);

  result = getDropdownBookingType('Other Public Transport');
  expected = publicTransportTypes[6];
  expect(result, expected);

  result = getDropdownBookingType('Historic');
  expected = activityTypes[0];
  expect(result, expected);

  result = getDropdownBookingType('Outdoors');
  expected = activityTypes[1];
  expect(result, expected);

  result = getDropdownBookingType('Culture');
  expected = activityTypes[2];
  expect(result, expected);

  result = getDropdownBookingType('Social');
  expected = activityTypes[3];
  expect(result, expected);

  result = getDropdownBookingType('Relaxing');
  expected = activityTypes[4];
  expect(result, expected);

  result = getDropdownBookingType('Adventure');
  expected = activityTypes[5];
  expect(result, expected);

  result = getDropdownBookingType('Dining');
  expected = activityTypes[6];
  expect(result, expected);

  result = getDropdownBookingType('');
  expected = activityTypes[7];
  expect(result, expected);
});
}