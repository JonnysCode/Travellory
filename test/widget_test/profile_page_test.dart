import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/home/pages/profile_page.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
      home: child,
    );
  }

  testWidgets('test if Page is the profile page', (WidgetTester tester) async {
    Widget page = ProfilePage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the HomePage is present.
    expect(find.byKey(Key('profile_page')), findsOneWidget);
  });

}