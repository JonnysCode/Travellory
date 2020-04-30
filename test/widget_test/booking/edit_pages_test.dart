import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/bookings/edit_activity.dart';
import 'package:travellory/services/database/edit.dart';

class TripsProviderMock extends Mock implements TripsProvider{}

final ActivityModel activityModel = ActivityModel()
  ..category = 'Historic'
  ..title = 'Museum visit'
  ..imageNr = 9
  ..imagePath = 'assets/images/activity/activity_9.png'
  ..location = "100 King's Cross Rd, London WC1X 9DT"
  ..startDate = '2020-05-01'
  ..startTime = '12:00'
  ..endDate = '2020-05-01';

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        editModel(activityModel, context);
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

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => const Wrapper(),
          '/edit/activity': (context) => EditActivity()
        },
      ),
    );
  }

  Future<void> pumpEditActivity(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if edit activity page is loaded', (WidgetTester tester) async {
    final testKey = Key('EditActivity');
    TripsProviderMock tripsProvider = TripsProviderMock();

    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );

    await tester.pumpWidget(makeTestableWidget(tripsProvider));

    expect(find.text('X'), findsOneWidget);
    expect(find.byKey(testKey, skipOffstage: false), findsNothing);

    await pumpEditActivity(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });
}
