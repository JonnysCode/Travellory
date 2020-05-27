import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/components/bookings/new_booking_models.dart';

void main() {
  TripModel tripModel = TripModel(
      name: 'Test Model',
      uid: '1234',
      startDate: '12-05-2020',
      endDate: '25-05-2020',
      destination: 'Munich',
      imageNr: 3);

  test('test', () {
    ModifyModelArguments arguments;

    arguments = passPublicTransportModel(tripModel);
    expect((arguments.model is PublicTransportModel), isTrue);
    expect(arguments.isNewModel, isTrue);

    arguments = passFlightModel(tripModel);
    expect((arguments.model is FlightModel), isTrue);
    expect(arguments.isNewModel, isTrue);

    arguments = passAccommodationModel(tripModel);
    expect((arguments.model is AccommodationModel), isTrue);
    expect(arguments.isNewModel, isTrue);

    arguments = passActivityModel(tripModel);
    expect((arguments.model is ActivityModel), isTrue);
    expect(arguments.isNewModel, isTrue);

    arguments = passRentalCarModel(tripModel);
    expect((arguments.model is RentalCarModel), isTrue);
    expect(arguments.isNewModel, isTrue);
  });
}