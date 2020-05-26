import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/schedule_entry.dart';
import 'package:travellory/src/components/schedule_cards/schedule_card.dart';

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

void main() {
  Widget makeTestableWidget({Widget page}) {
    return MaterialApp(
      home: Material(
        child: page
      ),
    );
  }

  testWidgets('test if booking is loaded', (WidgetTester tester) async {
    Widget page = ScheduleEntryCard(
      scheduleEntry: ScheduleEntry(
        booking: _rentalCar,
        dayType: DayType.single
      ),
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('schedule_entry_card')), findsOneWidget);
  });

  testWidgets('test if rental car is loaded', (WidgetTester tester) async {
    Widget page = ScheduleEntryCard(
      scheduleEntry: ScheduleEntry(
          booking: _rentalCar,
          dayType: DayType.single
      ),
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('rental_car')), findsOneWidget);
  });

  testWidgets('test if public transport is loaded', (WidgetTester tester) async {
    Widget page = ScheduleEntryCard(
      scheduleEntry: ScheduleEntry(
          booking: _publicTransport,
          dayType: DayType.single
      ),
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('public_transport')), findsOneWidget);
  });

  testWidgets('test if flight is loaded', (WidgetTester tester) async {
    Widget page = ScheduleEntryCard(
      scheduleEntry: ScheduleEntry(
          booking: _flight,
          dayType: DayType.single
      ),
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('flight')), findsOneWidget);
  });

  testWidgets('test if activity is loaded', (WidgetTester tester) async {
    Widget page = ScheduleEntryCard(
      scheduleEntry: ScheduleEntry(
          booking: _activity,
          dayType: DayType.single
      ),
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('activity')), findsOneWidget);
  });

  testWidgets('test if accommodation is loaded', (WidgetTester tester) async {
    Widget page = ScheduleEntryCard(
      scheduleEntry: ScheduleEntry(
          booking: _accommodation,
          dayType: DayType.single
      ),
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('accommodation')), findsOneWidget);
  });

}