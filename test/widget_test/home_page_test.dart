import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  testWidgets('test if all dials are present', (WidgetTester tester) async {
    Widget page = HomePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that dial is present.
    expect(find.byKey(Key('home_page_dial')), findsOneWidget);

    // Verify that all button are present.
    expect(find.byIcon(FontAwesomeIcons.envelope), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.theaterMasks), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.car), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.bus), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.bed), findsOneWidget);
    expect(find.byIcon(FontAwesomeIcons.plane), findsOneWidget);
  });
}