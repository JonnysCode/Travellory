import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/screens/accommodation/accommodation.dart';
import 'package:travellory/src/components/bookings/new_booking_models.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

TripModel tripModel = TripModel(
    name: 'Castle Discovery',
    startDate: '2020-05-12',
    endDate: '2020-05-25',
    destination: 'Munich',
    imageNr: 3);

ModifyModelArguments modelArguments() {
  AccommodationModel accommodationModel = AccommodationModel();
  accommodationModel.tripUID = tripModel.uid;
  return ModifyModelArguments(model: accommodationModel, isNewModel: true);
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/booking/accommodation', arguments: modelArguments());
      },
      child: Container(
        color: const Color(0xFFFFFF00),
        child: const Text('X'),
      ),
    );
  }
}

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => const Wrapper(),
          '/booking/accommodation': (context) => Accommodation()
        },
      ),
    );
  }

  Future<void> pumpAccommodation(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if accommodation page is loaded', (WidgetTester tester) async {
    final testKey = Key('Accommodation');
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    await pumpAccommodation(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    // verify that form is present
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if site title instance is found', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.byKey(Key('BookingSiteTitle'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if section title instances are found', (WidgetTester tester) async {
    final testKey = Key('SectionTitle');

    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsNWidgets(4));
  });

  testWidgets('test if dropdown menu instance is found', (WidgetTester tester) async {
    final testKey = Key('Dropdown Menu');

    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if first confirmation and address form field instances are found', (WidgetTester tester) async {
    final testKey = Key('Form Field');

    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.text('Confirmation Number', skipOffstage: false), findsOneWidget);
    expect(find.text('Address *', skipOffstage: false), findsOneWidget);

    expect(find.byKey(testKey, skipOffstage: false), findsNWidgets(2));
  });

  testWidgets('test if check-in date field instance is found', (WidgetTester tester) async {
    final testKey = Key('Date Field');

    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.text('Check-In Date *', skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNWidgets(2));
  });

  testWidgets('test if check-in time field instance is found', (WidgetTester tester) async {
    final testKey = Key('Time Field');

    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.text('Check-In Time', skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if animated list is present', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpAccommodation(tester);

    expect(find.byType(AnimatedList, skipOffstage: false), findsOneWidget);
  });
}
