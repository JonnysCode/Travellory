import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/bookings/add_activity.dart';

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
        home: Activity(),
      ),
    );
  }

  testWidgets('test if Activity page is loaded', (WidgetTester tester) async {
    final testKey = Key('Activity');

    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if form is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // Verify that form is present.
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byKey(Key('BookingSiteTitle')), findsOneWidget);
    expect(find.byKey(Key('SectionTitle')), findsNWidgets(4 ));
    expect(find.byKey(Key('Dropdown Menu')), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.clock, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.calendarAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.star, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.mapMarkerAlt, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.info, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.stickyNote, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton')), findsOneWidget);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton')), findsOneWidget);
  });
}
