import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
        home: child
    );
  }

  testWidgets('test if page is the friends page', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the friends page is present.
    expect(find.byKey(Key('friends_page')), findsOneWidget);
  });
}
