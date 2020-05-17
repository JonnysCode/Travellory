import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:provider/provider.dart';
import 'package:travellory/widgets/bookings/edit.dart';

class TripsProviderMock extends Mock implements TripsProvider {}

ModifyModelArguments passTestTripModel() {
  final TripModel _newTripModel = TripModel();
  return ModifyModelArguments(model: _newTripModel, isNewModel: true);
}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/createtrip', arguments: passTestTripModel());
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
          '/createtrip': (context) => CreateTrip()
        },
      ),
    );
  }

  Future<void> pumpTrip(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if create trip page is loaded', (WidgetTester tester) async {
    final testKey = Key('create_trip');

    TripsProviderMock tripsProvider = TripsProviderMock();
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpTrip(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpTrip(tester);

    // verify that form is present
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpTrip(tester);

    expect(find.text('Trip Details', skipOffstage: false), findsOneWidget);
    expect(find.text('General Information', skipOffstage: false), findsOneWidget);
    expect(find.text('End Date *', skipOffstage: false), findsOneWidget);
    expect(find.text('Destination *', skipOffstage: false), findsOneWidget);
    expect(find.text('Trip Title *', skipOffstage: false), findsOneWidget);
    expect(find.text('General Information', skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpTrip(tester);

    expect(find.byKey(Key('image_icon'), skipOffstage: false), findsNWidgets(11));
  });
}
