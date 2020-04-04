import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';

void main(){
  test('TripModel initiates its days right', () {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: '2020-05-12',
        endDate: '2020-05-21',
        destination: 'Munich',
        imageNr: 3
    );

    expect(tripModel.days.length, 10);
  });
}