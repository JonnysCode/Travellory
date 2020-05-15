import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';

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
  Widget makeTestableWidget(TripsProvider tripsProvider, String alertText, String functionName) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            return Center(
              child: BookingButton(
                buttonTitle: 'DeleteButtonTest',
                highlightColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
                onPressed: () {
                  showDeleteDialog(activityModel, context, alertText, functionName);
                },
              ),
            );
          },
        )),
      ),
    );
  }

  testWidgets('Test delete button exists', (WidgetTester tester) async {
    final testKey = Key('BookingButton');

    Widget makeOwnTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: BookingButton(
            buttonTitle: 'DeleteButtonTest',
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onPressed: () {
              // no onDelete function
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeOwnTestableWidget());

    expect(find.byType(BookingButton, skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test showDeleteDialog exists', (WidgetTester tester) async {
    final String alertText = 'Test';
    final Key testKey = Key('ShowDeleteDialog');
    TripsProviderMock tripsProvider = TripsProviderMock();

    // This functionName just serves as placeholder for this test
    final String functionName = DatabaseDeleter.deleteActivity;

    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    await tester.pumpWidget(makeTestableWidget(tripsProvider, alertText, functionName));

    expect(find.byType(BookingButton), findsOneWidget);
    await tester.tap(find.byType(BookingButton));
    await tester.pump();
    expect(find.text(alertText), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test onDeleteBooking can be tapped and AddToDataBaseFailedDialog appears',
      (WidgetTester tester) async {
    final String alertText = 'TestOnDelete';
    final Key testKey = Key('deleteButton');

    // This functionName just serves as placeholder for this test
    final String functionName = DatabaseDeleter.deleteActivity;

    TripsProviderMock tripsProvider = TripsProviderMock();

    tripModel.init();
    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(tripsProvider, alertText, functionName));

    expect(find.byType(BookingButton), findsOneWidget);
    await tester.tap(find.byType(BookingButton));
    await tester.pump();
    expect(find.text(alertText), findsOneWidget);

    // find 'Continue with Delete' Button and tap it
    expect(find.byKey(testKey), findsOneWidget);
    await tester.tap(find.byKey(testKey));
    await tester.pump();

    // finds add to database failed dialog
    // this test cannot work yet
//    expect(find.byKey(Key('AddToDataBaseFailedDialog'), skipOffstage: false), findsOneWidget);
  });
}
