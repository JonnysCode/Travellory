import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/rental_car.dart';
import 'package:travellory/widgets/bookings/edit.dart';

class TripsProviderMock extends Mock implements TripsProvider{}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, RentalCar.route, arguments: createRentalCarModel());
      },
      child: Container(
        color: const Color(0xFFFFFF00),
        child: const Text('X'),
      ),
    );
  }
}

TripModel tripModel = TripModel(
    name: 'Castle Discovery',
    startDate: '2020-05-12',
    endDate: '2020-05-25',
    destination: 'Munich',
    imageNr: 3);

ModifyModelArguments createRentalCarModel() {
  final RentalCarModel rentalCarTestModel = RentalCarModel();
  rentalCarTestModel.tripUID = tripModel.uid;
  return ModifyModelArguments(model: rentalCarTestModel, isNewModel: true);
}

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => const Wrapper(),
          '/booking/rentalcar': (context) => RentalCar()
        },
      ),
    );
  }

  Future<void> pumpRentalCar(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if Rental Car page is loaded', (WidgetTester tester) async {
    final testKey = Key('Rental Car');

    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpRentalCar(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpRentalCar(tester);

    // verify that form is present
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if form is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpRentalCar(tester);

    // Verify that form is present.
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpRentalCar(tester);

    expect(find.byKey(Key('BookingSiteTitle'), skipOffstage: false), findsOneWidget);
    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(5));
    expect(find.byIcon(FontAwesomeIcons.solidBuilding, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.clock, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.calendarAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.mapMarkerAlt, skipOffstage: false), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.car, skipOffstage: false), findsNWidgets(3));
    expect(find.byIcon(FontAwesomeIcons.ticketAlt, skipOffstage: false), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.stickyNote, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if submit button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpRentalCar(tester);

    // Verify that form is present.
    expect(find.byKey(Key('SubmitButton'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if cancel button is present', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpRentalCar(tester);

    // Verify that form is present.
    expect(find.byKey(Key('BookingButton'), skipOffstage: false), findsOneWidget);
  });
}