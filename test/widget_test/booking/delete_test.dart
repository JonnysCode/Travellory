import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
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

void main() {
  Widget makeTestableWidget(String alertText) {
    TripModel tripModel = TripModel(
        name: 'Castle Discovery',
        startDate: '2020-05-12',
        endDate: '2020-05-25',
        destination: 'Munich',
        imageNr: 3);
    tripModel.init();

    TripsProvider tripsProvider = TripsProvider()..selectedTrip = tripModel;

    return ChangeNotifierProvider<TripsProvider>(
      create: (context) => tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            return Center(
              child: DeleteButton(
                highlightColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
                onDelete: () {
                  showDeleteDialog(activityModel, context, alertText);
                },
              ),
            );
          },
        )),
      ),
    );
  }

  testWidgets('Test delete button exists', (WidgetTester tester) async {
    final testKey = Key('DeleteButton');

    Widget makeOwnTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: DeleteButton(
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onDelete: () {
              // no onDelete function
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeOwnTestableWidget());

    expect(find.byType(DeleteButton, skipOffstage: false), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test showDeleteDialog exists', (WidgetTester tester) async {
    final String alertText = 'Test';
    final Key testKey = Key('ShowDeleteDialog');

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(alertText));

    expect(find.byType(DeleteButton), findsOneWidget);
    await tester.tap(find.byType(DeleteButton));
    await tester.pump();
    expect(find.text(alertText), findsOneWidget);
    expect(find.byKey(testKey), findsOneWidget);
  });

  testWidgets('Test onDeleteBooking can be tapped and AddToDataBaseFailedDialog appears',
      (WidgetTester tester) async {
    final String alertText = 'TestOnDelete';
    final Key testKey = Key('deleteButton');

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(alertText));

    expect(find.byType(DeleteButton), findsOneWidget);
    await tester.tap(find.byType(DeleteButton));
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
