import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Test First Date Field exists', (WidgetTester tester) async {
    final formFieldDate = FormFieldDateWidget('Test Date', Icon(Icons.date_range));

    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return MaterialApp(
        home: Material(
          child: Scaffold(
            body: formFieldDate.firstDate(context),
          ),
        ),
      );
    }));

    expect(find.text('Test Date'), findsOneWidget);
    expect(find.byKey(Key('First Date Field')), findsOneWidget);
  });

  testWidgets('Test Time Field exists', (WidgetTester tester) async {
    final formFieldTime = FormFieldTimeWidget('Test Time', Icon(Icons.date_range));

    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return MaterialApp(
        home: Material(
          child: Scaffold(
            body: formFieldTime.time(context),
          ),
        ),
      );
    }));

    expect(find.text('Test Time'), findsOneWidget);
    expect(find.byKey(Key('Time Field')), findsOneWidget);
  });

  testWidgets('Test Time Field Required exists', (WidgetTester tester) async {
    final formFieldTime = FormFieldTimeWidget('Test Time', Icon(Icons.date_range));

    await tester.pumpWidget(Builder(builder: (BuildContext context) {
      return MaterialApp(
        home: Material(
          child: Scaffold(
            body: formFieldTime.timeRequired(context),
          ),
        ),
      );
    }));

    expect(find.text('Test Time'), findsOneWidget);
    expect(find.byKey(Key('Time Field Required')), findsOneWidget);
  });
}
