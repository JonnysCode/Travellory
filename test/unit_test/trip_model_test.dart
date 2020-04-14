import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/trip_model.dart';

TripModel tripModel = TripModel(
    name: 'Castle Discovery',
    startDate: '2020-05-12',
    endDate: '2020-05-21',
    destination: 'Munich',
    imageNr: 3
);

void main(){
  test('TripModel initiates its days right', () {
    tripModel.init();

    expect(tripModel.days.length, 10);
  });

  test('TripModel initiates its image path right', () {
    tripModel.init();

    expect(tripModel.imagePath, 'assets/images/home/trip/trip_3.png');
  });
}