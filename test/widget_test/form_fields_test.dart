import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/widgets/form_fields.dart';

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

    final FormFieldWidget testFormField =
        FormFieldWidget("Test Form Field", Icon(Icons.battery_std));

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
                  child: testFormField.optional(),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Test Form Field'), findsOneWidget);
  });

  testWidgets('TestFormField required exists', (WidgetTester tester) async {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    final FormFieldWidget testFormField =
        FormFieldWidget("Test Form Field", Icon(Icons.battery_std));

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
                  child: testFormField.required(),
                ),
              ),
            ),
          ),
        ),
      );
    }

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget());

    expect(find.text('Test Form Field'), findsOneWidget);

    Future<void> checkText(String testValue) async {
      await tester.enterText(find.byType(TextField), testValue);
      expect(testFormField.controller.text, equals(testValue));
    }

    await checkText('Test');
    await checkText('Hello');
  });

  testWidgets('TestFormField required has empty Text and validation is false',
      (WidgetTester tester) async {
    final GlobalKey<FormState> requiredFormKey = GlobalKey<FormState>();

    final FormFieldWidget testFormField =
        FormFieldWidget("Test Form Field", Icon(Icons.battery_std));

    Widget makeTestableWidget() {
      return MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(devicePixelRatio: 1.0),
          child: Directionality(
            textDirection: TextDirection.ltr,
            child: Center(
              child: Material(
                child: Form(
                  key: requiredFormKey,
                  child: testFormField.required(),
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
      return (requiredFormKey.currentState.validate());
    }

    Future<void> checkEmptyText() async {
      await tester.tap(find.byType(TextFormField));
      bool validate = validateForm();
      expect(testFormField.controller.text, equals(''));
      expect(validate, isFalse);
    }

    await checkEmptyText();
  });
}
