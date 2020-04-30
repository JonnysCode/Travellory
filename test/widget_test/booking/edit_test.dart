import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/edit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

final ActivityModel activityModel = ActivityModel()
  ..category = 'Historic'
  ..title = 'Museum visit'
  ..imageNr = 9
  ..imagePath = 'assets/images/activity/activity_9.png'
  ..location = "100 King's Cross Rd, London WC1X 9DT"
  ..startDate = '2020-05-01'
  ..startTime = '12:00'
  ..endDate = '2020-05-01';

class TripsProviderMock extends Mock implements TripsProvider {}

TripModel tripModel = TripModel(
    name: 'Castle Discovery',
    startDate: '2020-05-12',
    endDate: '2020-05-25',
    destination: 'Munich',
    imageNr: 3);

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider, String alertText) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            return Center(
              child: EditButton(
                highlightColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
                onEdit: () {
                  showEditedBookingDialog(context, alertText);
                },
              ),
            );
          },
        )),
      ),
    );
  }

  testWidgets('Test edit button exists', (WidgetTester tester) async {
    final testKey = Key('EditButton');

    Widget makeOwnTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: EditButton(
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onEdit: () {
              // no onEdit function
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeOwnTestableWidget());

    expect(find.byType(EditButton, skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test showEditedBookingDialog exists', (WidgetTester tester) async {
    final String alertText = 'Test';
    final Key testKey = Key('ShowEditedBookingDialog');
    TripsProviderMock tripsProvider = TripsProviderMock();

    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(tripsProvider, alertText));

    expect(find.byType(EditButton), findsOneWidget);
    await tester.tap(find.byType(EditButton));
    await tester.pump();
    expect(find.text(alertText), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });
}
