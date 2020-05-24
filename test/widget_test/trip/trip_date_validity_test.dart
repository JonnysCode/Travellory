import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/utils/trip_date_validity.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

TripModel tripModel = TripModel(
    name: 'Great England Trip',
    startDate: '12-05-2020',
    endDate: '25-05-2020',
    destination: 'London',
    imageNr: 3);

void setAccommodation(SingleTripProvider singleTripProvider) {
  final AccommodationModel accommodation = AccommodationModel()
    ..tripUID = tripModel.uid
    ..type = 'hotel'
    ..name = 'Travelodge'
    ..address = "100 King's Cross Rd, London WC1X 9DT"
    ..checkinDate = '14-05-2020'
    ..checkinTime = '12:00'
    ..checkoutDate = '25-05-2020';
  singleTripProvider.accommodations.add(accommodation);
}

void setActivity(SingleTripProvider singleTripProvider) {
  final ActivityModel activity = ActivityModel()
    ..tripUID = tripModel.uid
    ..description = 'Cinema'
    ..location = 'London Odeon'
    ..startDate = '14-05-2020'
    ..endDate = '14-05-2020'
    ..startTime = '20:00'
    ..endTime = '22:00';
  singleTripProvider.activities.add(activity);
}

void setFlight(SingleTripProvider singleTripProvider) {
  final FlightModel flight = FlightModel()
    ..tripUID = tripModel.uid
    ..departureLocation = 'Zürich'
    ..departureDate = '12-05-2020'
    ..departureTime = '7:30'
    ..arrivalLocation = 'London'
    ..arrivalDate = '12-05-2020'
    ..arrivalTime = '8:35';
  singleTripProvider.flights.add(flight);
}

void setRentalCar(SingleTripProvider singleTripProvider) {
  final RentalCarModel rentalCar = RentalCarModel()
    ..tripUID = tripModel.uid
    ..pickupLocation = 'London City'
    ..pickupDate = '14-05-2020'
    ..returnDate = '18-05-2020';
  singleTripProvider.rentalCars.add(rentalCar);
}

void setPublicTransport(SingleTripProvider singleTripProvider) {
  final PublicTransportModel publicTransport = PublicTransportModel()
    ..tripUID = tripModel.uid
    ..transportationType = 'Taxi'
    ..departureLocation = 'London City'
    ..departureDate = '14-05-2020'
    ..departureTime = '10:55'
    ..arrivalLocation = 'Gatwick Airport'
    ..arrivalDate = '14-05-2020'
    ..arrivalTime = '11:30';
  singleTripProvider.publicTransports.add(publicTransport);
}

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            bool tripDateIsValidBool = tripDateIsValid('2020-05-20', 'no label', context);
            expect(tripDateIsValidBool, isFalse);
            return Container();
          },
        )),
      ),
    );
  }

  SingleTripProvider getSingleTripProvider(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;

    return singleTripProvider;
  }

  testWidgets('Test if trip date with no label returns false', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    await tester.pumpWidget(makeTestableWidget(tripsProvider));
  });

  void setTrip(TripsProvider tripsProvider) {
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
  }

  Widget makeTestableWidgetTwo(TripsProvider tripsProvider, String newDate, String function) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            setTrip(tripsProvider);
            bool tripDateIsValidBool = tripDateIsValid(newDate, function, context);
            expect(tripDateIsValidBool, isTrue);
            return Container();
          },
        )),
      ),
    );
  }

  testWidgets('Test if trip date change with valid new start date works',
      (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    await tester.pumpWidget(makeTestableWidgetTwo(tripsProvider, '2020-05-20', 'Start Date *'));
  });

  testWidgets('Test if trip date change with valid new start date works',
      (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    await tester.pumpWidget(makeTestableWidgetTwo(tripsProvider, '2020-05-30', 'End Date *'));
  });

  void setModels(TripModel tripModel, BuildContext context) {
    final SingleTripProvider singleTripProvider = getSingleTripProvider(context);
    setPublicTransport(singleTripProvider);
    setActivity(singleTripProvider);
    setFlight(singleTripProvider);
    setRentalCar(singleTripProvider);
    setAccommodation(singleTripProvider);
  }

  Widget makeTestableWidgetThree(
      TripsProvider tripsProvider, String newDate, String function, Matcher matcher) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            setTrip(tripsProvider);
            setModels(tripModel, context);
            bool tripDateIsValidBool = tripDateIsValid(newDate, function, context);
            expect(tripDateIsValidBool, matcher);
            return Container();
          },
        )),
      ),
    );
  }

  testWidgets(
      'Test if trip date change with valid new start and end date works with bookings in the trip',
      (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    await tester
        .pumpWidget(makeTestableWidgetThree(tripsProvider, '01-05-2020', 'Start Date *', isTrue));
    await tester
        .pumpWidget(makeTestableWidgetThree(tripsProvider, '30-05-2020', 'End Date *', isTrue));
  });

  testWidgets(
      'Test if trip date change with invalid new start and end date fails with bookings in the trip',
      (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    await tester
        .pumpWidget(makeTestableWidgetThree(tripsProvider, '13-05-2020', 'Start Date *', isFalse));
    await tester
        .pumpWidget(makeTestableWidgetThree(tripsProvider, '20-05-2020', 'End Date *', isFalse));
  });

  Widget makeTestableWidgetAccommodation(
      TripsProvider tripsProvider, DateTime newDate, Matcher matcher) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            setTrip(tripsProvider);
            setAccommodation(getSingleTripProvider(context));
            bool tripDateIsValidBool =
                checkStartDateAccommodations(newDate, getSingleTripProvider(context));
            expect(tripDateIsValidBool, matcher);
            return Container();
          },
        )),
      ),
    );
  }

  testWidgets(
      'Test if trip date change with valid and invalid new start date works with accommodations in the trip',
      (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    final DateTime newValidDate = DateFormat("dd-MM-yyyy", "en_US").parse('01-05-2020');
    final DateTime newInvalidDate = DateFormat("dd-MM-yyyy", "en_US").parse('15-05-2020');

    await tester.pumpWidget(makeTestableWidgetAccommodation(tripsProvider, newValidDate, isTrue));
    await tester
        .pumpWidget(makeTestableWidgetAccommodation(tripsProvider, newInvalidDate, isFalse));
  });
}
