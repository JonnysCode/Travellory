import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/home/pages/calendar_page.dart';


void main() {
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: Material(child: child),
    );
  }

  testWidgets('test if CalendarPage is loaded', (WidgetTester tester) async {
    Widget page = CalendarPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the CalendarPage is present.
    expect(find.byKey(Key('calendar_page')), findsOneWidget);

  });

  testWidgets('test if navigation is present', (WidgetTester tester) async {
    Widget page = CalendarPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that yearly calendar is present.
    expect(find.byKey(Key('yearly_calendar')), findsOneWidget);
  });
}