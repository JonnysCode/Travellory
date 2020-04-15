import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/home/pages/calendar_page.dart';


void main() {
  Widget makeTestableWidget({Widget body}) {
    UserModel user = UserModel(uid: 'uid', displayName: 'name');
    return Provider<UserModel>.value(
      value: user,
      child: MaterialApp(
        home: Scaffold(
          body: body,
        ),
      ),
    );
  }

  testWidgets('test if CalendarPage is loaded', (WidgetTester tester) async {
    Widget page = CalendarPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(body: page));

    // Verify that the CalendarPage is present.
    expect(find.byKey(Key('calendar_page')), findsOneWidget);

  });

  testWidgets('test if navigation is present', (WidgetTester tester) async {
    Widget page = CalendarPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(body: page));

    // Verify that yearly calendar is present.
    expect(find.byKey(Key('yearly_calendar')), findsOneWidget);
  });
}