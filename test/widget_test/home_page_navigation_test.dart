import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/screens/home/home.dart';

void main(){
  Widget makeTestableWidget({Widget child}){
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if HomePage is the starting page', (WidgetTester tester) async {
    Widget page = Home();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('home_page')), findsOneWidget);
  });

  testWidgets('test if navigation is present', (WidgetTester tester) async {
    Widget page = Home();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that navigation is present.
    expect(find.byKey(Key('nav_bar')), findsOneWidget);

    // Verify that all button are present.
    expect(find.byIcon(FontAwesomeIcons.suitcaseRolling), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.calendarAlt), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.globeAfrica), findsNWidgets(2));
    expect(find.byIcon(FontAwesomeIcons.userAlt), findsNWidgets(2));
  });
}