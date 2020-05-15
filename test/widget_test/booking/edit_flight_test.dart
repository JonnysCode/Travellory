import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/flight.dart';
import 'package:travellory/services/database/edit.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        editModel(flightModel, context);
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

final FlightModel flightModel = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureDate = '2020-05-01'
  ..departureTime = '7:30'
  ..arrivalLocation = 'London'
  ..arrivalDate = '2020-05-01'
  ..arrivalTime = '8:35';

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => const Wrapper(),
          '/booking/flight': (context) => Flight()
        },
      ),
    );
  }

  Future<void> pumpEditActivity(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if edit flight page is loaded', (WidgetTester tester) async {
    final testKey = Key('Flight');
    TripsProviderMock tripsProvider = TripsProviderMock();

    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpEditActivity(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });
}
