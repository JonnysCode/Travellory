import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/screens/activity/activity.dart';
import 'package:travellory/src/components/bookings/new_booking_models.dart';

class TripsProviderMock extends Mock implements TripsProvider{}

class Wrapper extends StatelessWidget {
  const Wrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Activity.route, arguments: createActivityModel());
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

ModifyModelArguments createActivityModel() {
  final ActivityModel activityTestModel = ActivityModel();
  activityTestModel.tripUID = tripModel.uid;
  return ModifyModelArguments(model: activityTestModel, isNewModel: true);
}

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        routes: <String, WidgetBuilder>{
          '/': (context) => const Wrapper(),
          '/booking/activity': (context) => Activity()
        },
      ),
    );
  }

  Future<void> pumpActivity(WidgetTester tester) async {
    await tester.tap(find.text('X'));
    await tester.pump();
  }

  testWidgets('test if Activity page is loaded', (WidgetTester tester) async {
    final testKey = Key('Activity');
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpActivity(tester);

    expect(find.byKey(testKey, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if form instance is found', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpActivity(tester);

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
    await pumpActivity(tester);

    // Verify that form is present.
    expect(find.byType(Form, skipOffstage: false), findsOneWidget);
  });

  testWidgets('test if all form fields are present', (WidgetTester tester) async {
    TripsProviderMock tripsProvider = TripsProviderMock();

    when(tripsProvider.selectedTrip).thenReturn(
        SingleTripProvider(tripModel, null)
    );
    await tester.pumpWidget(makeTestableWidget(tripsProvider));
    await pumpActivity(tester);

    expect(find.byKey(Key('BookingSiteTitle'), skipOffstage: false), findsOneWidget);
    expect(find.byKey(Key('SectionTitle'), skipOffstage: false), findsNWidgets(4 ));
    expect(find.byKey(Key('Dropdown Menu'), skipOffstage: false), findsOneWidget);
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
    await pumpActivity(tester);

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
    await pumpActivity(tester);

    // Verify that form is present.
    expect(find.byKey(Key('BookingButton'), skipOffstage: false), findsOneWidget);
  });
}
