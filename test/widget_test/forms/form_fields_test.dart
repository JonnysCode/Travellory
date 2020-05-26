import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/components/forms/form_field.dart';

void main() {
  testWidgets('form test: onSaved callback is called', (WidgetTester tester) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    String fieldValue;

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                  key: formKey,
                  child: TextFormField(
                    onSaved: (String value) {
                      fieldValue = value;
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(fieldValue, isNull);

    Future<void> checkText(String testValue) async {
      await tester.enterText(find.byType(TextFormField), testValue);
      formKey.currentState.save();
      // Pumping is unnecessary because callback happens regardless of frames.
      expect(fieldValue, equals(testValue));
    }

    await checkText('Test');
    await checkText('');
  });

  testWidgets('TestFormField optional exists', (WidgetTester tester) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final TravelloryFormField testFormField = TravelloryFormField(
      labelText: 'Test',
      icon: Icon(Icons.confirmation_number),
      optional: true,
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
                  key: formKey,
                  child: testFormField,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Test'), findsOneWidget);
  });

  testWidgets('TestFormField required exists', (WidgetTester tester) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    // for testing purposes we will use a rental car model here
    final RentalCarModel testModel = RentalCarModel();

    final TravelloryFormField testFormField = TravelloryFormField(
      labelText: 'Test Booking Company',
      icon: Icon(Icons.supervised_user_circle),
      optional: true,
      onChanged: (value) => testModel.company = value,
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
                  key: formKey,
                  child: testFormField,
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Test Booking Company'), findsOneWidget);

    Future<void> checkText(String testValue) async {
      await tester.enterText(find.byType(TextField), testValue);
      expect(testModel.company, equals(testValue));
    }

    await checkText('Test');
    await checkText('Company');
  });

//  testWidgets('TestFormField required has empty Text and validation is false',
//      (WidgetTester tester) async {
//    final GlobalKey<FormState> requiredFormKey = GlobalKey<FormState>();
//
//    // for testing purposes we will use a rental car model here
//    final RentalCarModel testModel = RentalCarModel();
//
//    final TravelloryFormField testFormField = TravelloryFormField(
//      labelText: 'Test',
//      icon: Icon(Icons.confirmation_number),
//      optional: false,
//      onChanged: (value) => testModel.company = value,
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
//                  key: requiredFormKey,
//                  child: testFormField,
//                ),
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
//    bool validateForm() {
//      return (requiredFormKey.currentState.validate());
//    }
//
//    Future<void> checkEmptyText() async {
//      await tester.tap(find.byType(TextFormField));
//      bool validate = validateForm();
//      expect(testModel.company, equals(null));
//      expect(validate, isFalse);
//    }
//
//    await checkEmptyText();
//  });
//
//  testWidgets('TestFormField optional has empty Text and validation is true',
//          (WidgetTester tester) async {
//        final GlobalKey<FormState> requiredFormKey = GlobalKey<FormState>();
//
//        // for testing purposes we will use a rental car model here
//        final RentalCarModel testModel = RentalCarModel();
//
//        final TravelloryFormField testFormField = TravelloryFormField(
//          labelText: 'Test',
//          icon: Icon(Icons.confirmation_number),
//          optional: true,
//          onChanged: (value) => testModel.company = value,
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
//                      key: requiredFormKey,
//                      child: testFormField,
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
//          return (requiredFormKey.currentState.validate());
//        }
//
//        Future<void> checkEmptyText() async {
//          await tester.tap(find.byType(TextFormField));
//          bool validate = validateForm();
//          expect(testModel.company, equals(null));
//          expect(validate, isTrue);
//        }
//
//        await checkEmptyText();
//      });
}
