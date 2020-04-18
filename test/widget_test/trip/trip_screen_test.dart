import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/trip/schedule/booking_card.dart';

final PublicTransportModel _publicTransport = PublicTransportModel()
  ..transportationType = 'Taxi'
  ..departureLocation = 'London City'
  ..departureDate = '2020-05-04'
  ..departureTime = '10:55'
  ..arrivalLocation = 'Gatwick Airport'
  ..arrivalDate = '2020-05-04'
  ..arrivalTime = '11:30';

final AccommodationModel _accommodation = AccommodationModel()
  ..type = 'hotel'
  ..name = 'Travelodge'
  ..address = "100 King's Cross Rd, London WC1X 9DT"
  ..checkinDate = '2020-05-01'
  ..checkinTime = '12:00';

final ActivityModel _activity = ActivityModel()
  ..description = 'Cinema'
  ..location = 'London Odeon'
  ..startTime = '20:00'
  ..endTime = '22:00';

final FlightModel _flight = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureDate = '2020-05-01'
  ..departureTime = '7:30'
  ..arrivalLocation = 'London'
  ..arrivalDate = '2020-05-01'
  ..arrivalTime = '8:35';

final RentalCarModel _rentalCar = RentalCarModel()
  ..pickupLocation = 'London City'
  ..pickupDate = '2020-05-02';

void main() {
  Widget makeTestableWidget({Widget page}) {
    return MaterialApp(
      home: Material(
          child: page
      ),
    );
  }

  testWidgets('test if booking is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _rentalCar,
        color: getBookingColorAccordingTo(_rentalCar),
        getSchedule: getBookingsAccordingTo(_rentalCar));

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('booking_card'),), findsOneWidget);
  });

  testWidgets('test if rental car is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _rentalCar,
        color: getBookingColorAccordingTo(_rentalCar),
        getSchedule: getBookingsAccordingTo(_rentalCar));

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('rentalCarBookings')), findsOneWidget);
  });

  testWidgets('test if public transport is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _publicTransport,
        color: getBookingColorAccordingTo(_publicTransport),
        getSchedule: getBookingsAccordingTo(_publicTransport));

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('publicTransportBookings')), findsOneWidget);
  });

  testWidgets('test if flight is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _flight,
        color: getBookingColorAccordingTo(_flight),
        getSchedule: getBookingsAccordingTo(_flight));

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('flightBookings')), findsOneWidget);
  });

  testWidgets('test if accommodation is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _accommodation,
        color: getBookingColorAccordingTo(_accommodation),
        getSchedule: getBookingsAccordingTo(_accommodation));

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('accommodationBookings')), findsOneWidget);
  });

}