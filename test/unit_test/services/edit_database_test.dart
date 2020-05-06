import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/services/database/edit_database.dart';

final PublicTransportModel _publicTransport = PublicTransportModel()
  ..transportationType = 'train'
  ..departureLocation = 'Los Angeles'
  ..departureTime = '13:35'
  ..arrivalLocation = 'Las Vegas'
  ..arrivalTime = '15:40';

final AccommodationModel _accommodation = AccommodationModel()
  ..type = 'hotel'
  ..name = 'Novotel Suites'
  ..address = 'Bluff Street 102, 28343 Los Angeles'
  ..checkinTime = '13:00';

final ActivityModel _activity = ActivityModel()
  ..description = 'Surfing Class'
  ..location = 'Long Beach'
  ..startTime = '14:00'
  ..endTime = '18:00';

final FlightModel _flight = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureTime = '9:30'
  ..arrivalLocation = 'Los Angeles'
  ..arrivalTime = '12:20';

final RentalCarModel _rentalCar = RentalCarModel()
  ..pickupLocation = 'Los Angeles Airport';

void main(){
  test('test getEditDeleteFunctionNameBasedOn model', () async {

    expect('booking-updateFlight', getEditFunctionNameBasedOn(_flight));
    expect('booking-updateRentalCar', getEditFunctionNameBasedOn(_rentalCar));
    expect('booking-updateAccommodation', getEditFunctionNameBasedOn(_accommodation));
    expect('booking-updatePublicTransportation', getEditFunctionNameBasedOn(_publicTransport));
    expect('activity-updateActivity', getEditFunctionNameBasedOn(_activity));
  });


}