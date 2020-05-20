import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/utils/trip_date_validity.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';
import 'package:travellory/widgets/buttons/submit_button.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';

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
    name: 'London Trip',
    startDate: '2020-05-01',
    endDate: '2020-05-10',
    destination: 'London',
    imageNr: 3);

void main() {
  Widget makeTestableWidget(TripsProvider tripsProvider) {
    return ChangeNotifierProvider<TripsProvider>.value(
      value: tripsProvider,
      child: MaterialApp(
        home: Material(child: Builder(
          builder: (BuildContext context) {
            return Center(
              child: BookingButton(
                buttonTitle: 'Test',
                highlightColor: Theme.of(context).primaryColor,
                fillColor: Theme.of(context).primaryColor,
                onPressed: () {
                  tripDateIsValid('2020-05-20', null, context);
                },
              ),
            );
          },
        )),
      ),
    );
  }

//  testWidgets('Test if tripDateisValid returns false when called with null as labelText',
//      (WidgetTester tester) async {
//    TripsProviderMock tripsProvider = TripsProviderMock();
//
//    when(tripsProvider.selectedTrip).thenReturn(SingleTripProvider(tripModel, null));
//
//    await tester.pumpWidget(
//      Builder(
//        builder: (BuildContext context) {
//          bool tripDateIsValidBool = tripDateIsValid('2020-05-20', 'no label', context);
//          expect(tripDateIsValidBool, isFalse);
//          // The builder function must return a widget.
//          return Container();
//        },
//      ),
//    );
//  });

//  Future<void> enterDate(String date, Key key, WidgetTester tester) async {
//    await tester.tap(find.byKey(key));
//    Finder dateField = find.byKey(key);
//    await tester.showKeyboard(dateField);
//    await tester.enterText(dateField, date);
//  }
//
//  testWidgets('test if submit edit works', (WidgetTester tester) async {
//    TripsProviderMock tripsProvider = TripsProviderMock();
//    await tester.pumpWidget(makeTestableWidget(tripsProvider));
//    await pumpTrip(tester);
//
//    // verify that submit button is present
//    expect(find.byType(SubmitButton, skipOffstage: false), findsOneWidget);
////
////    // find start date field and tap it
////    Finder dateField = find.text('Start Date *', skipOffstage: false);
////    await tester.tap(dateField);
////    await tester.pumpAndSettle();
//
//    await tester.tap(find.text('Start Date *'));
//    await tester.pumpAndSettle();
//
//    //    await tester.showKeyboard(dateField);
//    // enter start date that is before start of trip , so it is valid
//    await tester.enterText(find.byType(TextField), '2020-04-28');
//    await tester.tap(find.text('OK'));
//    await tester.pumpAndSettle();
//    expect(find.byKey(Key('ShowEditedBookingDialog'), skipOffstage: false), findsOneWidget);
//
////    // tap submit button
////    await tester.tap(find.byType(SubmitButton, skipOffstage: false));
////    await tester.pump();
//  });
//
//  testWidgets('Test Date Field required exists and validation for empty fails',
//          (WidgetTester tester) async {
//        final GlobalKey<FormState> testKey = GlobalKey<FormState>();
//
//        TripModel tripModel = TripModel(
//            name: 'London Trip',
//            startDate: '2020-05-01',
//            endDate: '2020-05-02',
//            destination: 'London',
//            imageNr: 3);
//
//        final DateFormField testDate = DateFormField(
//          isNewTrip: false,
//          initialValue: tripModel.startDate,
//          labelText: 'Test Date',
//          icon: Icon(Icons.date_range),
//          optional: false,
//          chosenDateString: (value) => tripModel.startDate = value,
//        );
//
//        Widget makeTestableWidget() {
//          return MaterialApp(
//            home: MediaQuery(
//              data: const MediaQueryData(devicePixelRatio: 1.0),
//              child: Directionality(
//                textDirection: TextDirection.ltr,
//                child: Center(
//                  child: Material(
//                    child: Form(
//                      key: testKey,
//                      child: testDate,
//                    ),
//                  ),
//                ),
//              ),
//            ),
//          );
//        }
//
//        // Build our app and trigger a frame.
//        await tester.pumpWidget(makeTestableWidget());
//
//        bool validateForm() {
//          return (testKey.currentState.validate());
//        }
//
//        Future<void> checkEmptyText() async {
//          await tester.tap(find.byType(TextFormField));
//          bool validate = validateForm();
//          expect(tripModel.startDate, equals(''));
//          expect(validate, isFalse);
//        }
//
//        await checkEmptyText();
//      });
//
//  testWidgets('Test Date Field enter date works', (WidgetTester tester) async {
//    final GlobalKey<FormState> testKey = GlobalKey<FormState>();
//    final GlobalKey<DateFormFieldState> testDateFieldKey = GlobalKey<DateFormFieldState>();
//
//    final ActivityModel activityModel = ActivityModel()
//      ..category = 'Historic'
//      ..title = 'Museum visit'
//      ..imageNr = 9
//      ..imagePath = 'assets/images/activity/activity_9.png'
//      ..location = "100 King's Cross Rd, London WC1X 9DT"
//      ..startDate = '2020-05-01'
//      ..startTime = '12:00'
//      ..endDate = '2020-05-01';
//
//    TripModel tripModel = TripModel(
//        name: 'Test Trip',
//        startDate: '01-05-2020',
//        endDate: '05-05-2020',
//        destination: 'London',
//        imageNr: 3);
//
//    final DateFormField testDate = DateFormField(
//      isNewTrip: false,
//      initialValue: tripModel.startDate,
//      key: testDateFieldKey,
//      labelText: 'Start Date *',
//      icon: Icon(Icons.date_range),
//      optional: false,
//      chosenDateString: (value) => tripModel.startDate = value,
//    );
//
//    Widget makeTestableWidget() {
//      return MaterialApp(
//        home: MediaQuery(
//          data: const MediaQueryData(devicePixelRatio: 1.0),
//          child: Directionality(
//            textDirection: TextDirection.ltr,
//            child: Center(
//              child: Material(
//                child: Form(
//                    key: testKey,
//                    child: Column(children: <Widget>[
//                      testDate,
//                    ])),
//              ),
//            ),
//          ),
//        ),
//      );
//    }
//
//    // Build our app and trigger a frame.
//    await tester.pumpWidget(makeTestableWidget());
//
//    expect(find.byKey(testDateFieldKey, skipOffstage: false), findsOneWidget);
//
//    await enterDate('01-05-2020', testDateFieldKey, tester);
//    await tester.pump();
//
//    // tap submit button
//    await tester.tap(find.byType(SubmitButton, skipOffstage: false));
//    await tester.pump();
//
//  });
}
