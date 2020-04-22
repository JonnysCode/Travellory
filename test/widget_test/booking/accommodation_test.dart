import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/bookings/add_accommodation.dart';

void main() {
  Widget makeTestableWidget() {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: '2020-05-12',
        endDate: '2020-05-25',
        destination: 'Munich',
        imageNr: 3);
    tripModel.init();

    TripsProvider tripsProvider = TripsProvider()
        ..selectedTrip = tripModel;

    return ChangeNotifierProvider<TripsProvider>(
      create: (context) => tripsProvider,
      child: MaterialApp(
        home: Accommodation(),
      ),
    );
  }

  testWidgets('test if accommodation page is loaded', (WidgetTester tester) async {
    final testKey = Key('Accommodation');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if site title instance is found', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(Key('BookingSiteTitle')), findsOneWidget);
  });

  testWidgets('test if section title instances are found', (WidgetTester tester) async {
    final testKey = Key('SectionTitle');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey), findsNWidgets(2));
  });

  testWidgets('test if dropdown menu instance is found', (WidgetTester tester) async {
    final testKey = Key('Dropdown Menu');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if first three form field instances are found', (WidgetTester tester) async {
    final testKey = Key('Form Field');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Confirmation Number'), findsOneWidget);
    expect(find.text('Name *'), findsOneWidget);
    expect(find.text('Address *'), findsOneWidget);

    expect(find.byKey(testKey), findsNWidgets(3));
  });

  testWidgets('test if check-in date field instance is found', (WidgetTester tester) async {
    final testKey = Key('Date Field');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Check-In Date *'), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if check-in time field instance is found', (WidgetTester tester) async {
    final testKey = Key('Time Field');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Check-In Time'), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if animated list is present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(AnimatedList), findsOneWidget);
  });
}
