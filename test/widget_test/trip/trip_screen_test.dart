import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
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
import 'package:travellory/screens/trip/trip_screen.dart';
import 'package:travellory/widgets/booking_cards/booking_card.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/viewtrip');
      },
      child: Container(
        color: const Color(0xFFFFFF00),
        child: const Text('X'),
      ),
    );
  }
}

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

TripModel tripModel = TripModel(
    name: 'Castle Discovery',
    startDate: '2020-05-12',
    endDate: '2020-05-25',
    destination: 'Munich',
    imageNr: 3);

void main() {
  Widget makeTestableWidget({Widget page}) {
    return MaterialApp(
      home: Material(child: page),
    );
  }

  Widget makeTestableWidgetWithProvider(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => const Wrapper(),
          '/viewtrip': (context) => TripScreen()
        },
      ),
    );
  }

  Future<void> pumpTrip(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if tripscreen is loaded', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    await tester.pumpWidget(makeTestableWidgetWithProvider(tripsProvider));
    await pumpTrip(tester);

    expect(find.byKey(Key('TripScreen'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if sub section instances are found', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    await tester.pumpWidget(makeTestableWidgetWithProvider(tripsProvider));
    await pumpTrip(tester);

    expect(find.byKey(Key('SubSection'), skipOffstage: false), findsNWidgets(5));
  });

  testWidgets('test if trip header instance is found', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    await tester.pumpWidget(makeTestableWidgetWithProvider(tripsProvider));
    await pumpTrip(tester);

    expect(find.byKey(Key('TripHeader'), skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if booking is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _rentalCar,
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('booking_card')), findsOneWidget);
  });

  testWidgets('test if rental car is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _rentalCar,
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('rentalCarBookings')), findsOneWidget);
  });

  testWidgets('test if activity is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _activity,
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('activityBookings')), findsOneWidget);
  });

  testWidgets('test if public transport is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _publicTransport,
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('publicTransportBookings')), findsOneWidget);
  });

  testWidgets('test if flight is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _flight,
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('flightBookings')), findsOneWidget);
  });

  testWidgets('test if accommodation is loaded', (WidgetTester tester) async {
    Widget page = BookingCard(
        model: _accommodation,
    );

    await tester.pumpWidget(makeTestableWidget(page: page));

    expect(find.byKey(Key('accommodationBookings')), findsOneWidget);
  });
}
