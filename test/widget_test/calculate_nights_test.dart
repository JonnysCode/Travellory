import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/widgets/forms/calculate_nights.dart';

void main() {
  test('Calculate correct nights for Accommodation', () {
    final AccommodationModel testModel = AccommodationModel()
      ..type = 'hotel'
      ..name = 'Travelodge'
      ..address = "100 King's Cross Rd, London WC1X 9DT"
      ..checkinDate = '01-05-2020'
      ..checkinTime = '12:00'
      ..checkoutDate = '05-05-2020';

    AccommodationModel resultModel = calculateNightsForAccommodation(testModel);

    String expected = '4';
    expect(resultModel.nights, expected);
  });
}