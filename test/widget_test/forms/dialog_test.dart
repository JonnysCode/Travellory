import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/buttons/submit_button.dart';

void main() {
  testWidgets('Test submit button exists', (WidgetTester tester) async {
    final testKey = Key('ShowSubmittedBookingDialog');

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();
    final String alertText = 'Test';

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: SubmitButton(
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Theme.of(context).primaryColor,
            onSubmit: onSubmitBooking(SingleTripProvider(TripModel(), null), testModel,
                'booking-addTest', context, alertText),
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(SubmitButton), findsOneWidget);
  });

  testWidgets('Test cancellingDialog exists', (WidgetTester tester) async {
    final String cancelText = 'Test';

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: BookingButton(
            buttonTitle: 'CANCEL',
            highlightColor: Theme.of(context).primaryColor,
            fillColor: Color(0xFFF48FB1),
            onPressed: () {
              cancellingDialog(context, cancelText);
            },
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(BookingButton), findsOneWidget);
    await tester.tap(find.byType(BookingButton));
    await tester.pump();
    expect(find.text(cancelText), findsOneWidget);
  });

  testWidgets('Test ShowSubmittedBookingDialog is created', (WidgetTester tester) async {
    final String alertText = 'Test';

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: RaisedButton(
            onPressed: () => showSubmittedBookingDialog(context, alertText),
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();
    expect(find.byKey(Key('ShowSubmittedBookingDialog')), findsOneWidget);
  });

  testWidgets('Test showSubmittedTripDialog is created', (WidgetTester tester) async {
    final String alertText = 'Test';

    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: RaisedButton(
            onPressed: () => showSubmittedTripDialog(context, alertText),
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();
    expect(find.byKey(Key('showSubmittedTripDialog')), findsOneWidget);
  });

  testWidgets('Test missingFormFieldInformationDialog is created', (WidgetTester tester) async {
    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: RaisedButton(
            onPressed: () => missingFormFieldInformationDialog(context),
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();
    expect(find.byKey(Key('MissingFormFieldInformationDialog')), findsOneWidget);
  });

  testWidgets('Test addToDataBaseFailedDialog is created', (WidgetTester tester) async {
    Widget makeTestableWidget() {
      return MaterialApp(home: Material(child: Builder(builder: (BuildContext context) {
        return Center(
          child: RaisedButton(
            onPressed: () => addToDataBaseFailedDialog(context),
          ),
        );
      })));
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.byType(RaisedButton), findsOneWidget);
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();
    expect(find.byKey(Key('AddToDataBaseFailedDialog')), findsOneWidget);
  });
}
