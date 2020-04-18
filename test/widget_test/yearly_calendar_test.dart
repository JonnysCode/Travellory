import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/home/pages/calendar_page.dart';

class MockTripsProvider extends Mock implements TripsProvider{}

void main() {
  Widget makeTestableWidget({Widget body, TripsProvider tripsProvider}) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('test if CalendarPage is loaded', (WidgetTester tester) async {
    Widget page = CalendarPage();
    // Mock the trips provider to return an empty TripModel list
    MockTripsProvider mockTripsProvider = MockTripsProvider();
    when(mockTripsProvider.trips).thenReturn(<TripModel>[]);
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(body: page, tripsProvider: mockTripsProvider));

    // Verify that the CalendarPage is present.
    expect(find.byKey(Key('calendar_page')), findsOneWidget);

  });

  testWidgets('test if navigation is present', (WidgetTester tester) async {
    Widget page = CalendarPage();
    // Mock the trips provider to return an empty TripModel list
    MockTripsProvider mockTripsProvider = MockTripsProvider();
    when(mockTripsProvider.trips).thenReturn(<TripModel>[]);
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(body: page, tripsProvider: mockTripsProvider));

    // Verify that yearly calendar is present.
    expect(find.byKey(Key('yearly_calendar')), findsOneWidget);
  });
}