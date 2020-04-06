import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

void main() {

  testWidgets('Test First Date Field exists', (WidgetTester tester) async {
    final GlobalKey<FormState> testKey = GlobalKey<FormState>();

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();

    final DateFormField testDate = DateFormField(
      labelText: "Test Date",
      icon: Icon(Icons.date_range),
      optional: false,
      chosenDateString: (value) => testModel.pickupDate = value,
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
                  child: testDate,
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
      expect(testModel.pickupDate, equals(null));
      expect(validate, isFalse);
    }

    await checkEmptyText();
  });

//  testWidgets('Test Time Field exists', (WidgetTester tester) async {
//    final testTime = TimeFormField(
//      key: Key('Time Field'),
//      labelText: "Test Time",
//      icon: Icon(Icons.access_time),
//      optional: true,
//      chosenTimeString: (value) => testModel.pickupTime = value,
//    );
//
//    await tester.pumpWidget(Builder(builder: (BuildContext context) {
//      return MaterialApp(
//        home: Material(
//          child: Scaffold(
//            body: testTime,
//          ),
//        ),
//      );
//    }));
//
//    expect(find.text('Test Time'), findsOneWidget);
//    expect(find.byKey(Key('Time Field')), findsOneWidget);
//  });
//
//  testWidgets('Test Time Field Required exists', (WidgetTester tester) async {
//    final formFieldTime = TimeFormField(
//      key: Key('Time Field Required'),
//      labelText: "Test Time",
//      icon: Icon(Icons.access_time),
//      optional: true,
//      chosenTimeString: (value) => testModel.pickupTime = value,
//    );
//
//    await tester.pumpWidget(Builder(builder: (BuildContext context) {
//      return MaterialApp(
//        home: Material(
//          child: Scaffold(
//            body: formFieldTime,
//          ),
//        ),
//      );
//    }));
//
//    expect(find.text('Test Time'), findsOneWidget);
//    expect(find.byKey(Key('Time Field Required')), findsOneWidget);
//  });
}
