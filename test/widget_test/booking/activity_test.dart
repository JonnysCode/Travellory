import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/add_activity.dart';

class TripsProviderMock extends Mock implements TripsProvider{}

TripModel tripModel = TripModel(
    name: 'Castle Discovery',
    startDate: '2020-05-12',
    endDate: '2020-05-25',
    destination: 'Munich',
    imageNr: 3);

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Activity(),
      ),
    );
  }

  testWidgets('test if Activity page is loaded', (WidgetTester tester) async {
    final testKey = Key('Activity');
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    // verify that form is present
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if form is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    // Verify that form is present.
    expect(find.byType(Form), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

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
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton')), findsOneWidget);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    // Verify that form is present.
    expect(find.byKey(Key('CancelButton')), findsOneWidget);
  });
}
