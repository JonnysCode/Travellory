import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/components/forms/time_form_field.dart';
import 'package:travellory/src/models/rental_car_model.dart';

void main() {
  testWidgets('Test Time Field Required exists and validation for empty fails',
      (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();

    final testTime = TimeFormField(
      key: Key('Time Field Required'),
      labelText: "Test Time",
      icon: Icon(Icons.access_time),
      optional: false,
      chosenTimeString: (value) => testModel.pickupTime = value,
    );

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                  key: testKey,
                  child: testTime,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    bool validateForm() {
      return (testKey.currentState.validate());
    }

    Future<void> checkEmptyText() async {
      await tester.tap(find.byType(TextFormField));
      bool validate = validateForm();
      expect(testModel.pickupTime, equals(''));
      expect(validate, isFalse);
    }

    await checkEmptyText();
  });

  testWidgets('Test Time Field optional exists and validation for empty passes',
      (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();

    final testTime = TimeFormField(
      key: Key('Time Field Required'),
      labelText: "Test Time",
      icon: Icon(Icons.access_time),
      optional: true,
      chosenTimeString: (value) => testModel.pickupTime = value,
    );

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                  key: testKey,
                  child: testTime,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    bool validateForm() {
      return (testKey.currentState.validate());
    }

    Future<void> checkEmptyText() async {
      await tester.tap(find.byType(TextFormField));
      bool validate = validateForm();
      expect(testModel.pickupTime, equals(''));
      expect(validate, isTrue);
    }

    await checkEmptyText();
  });
}
