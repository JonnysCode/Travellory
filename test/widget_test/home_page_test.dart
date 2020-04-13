import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/home/pages/home_page.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if HomePage is rendered', (WidgetTester tester) async {
    Widget page = HomePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('home_page')), findsOneWidget);
  });

  testWidgets('test if SpeedDial is rendered', (WidgetTester tester) async {
    Widget page = HomePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('home_page_dial')), findsOneWidget);
  });

  testWidgets('test if HomePage is rendered', (WidgetTester tester) async {
    Widget page = HomePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('home_schedule')), findsOneWidget);
  });

}