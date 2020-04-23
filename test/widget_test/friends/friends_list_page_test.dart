import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/screens/friends/friends_list_page.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MaterialApp(
        home: child
    );
  }

  testWidgets('test if friend_requests_list is present', (WidgetTester tester) async {
    FriendListPage page = FriendListPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the friends_request_list page is present.
    expect(find.byKey(Key('friend_requests_list')), findsOneWidget);
  });

  testWidgets('test if friends_list is present', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the friends_request_list page is present.
    expect(find.byKey(Key('friends_list')), findsOneWidget);
  });

  testWidgets('test if buttons for friends requests are present', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the buttons for friends_request_list is present.
    expect(find.byKey(Key('accept_button')), findsNWidgets(4));
    expect(find.byKey(Key('decline_button')), findsNWidgets(4));
  });

  testWidgets('test if button for removing friends', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the button for friend_list is present.
    expect(find.byKey(Key('accept_button')), findsNWidgets(4));
  });

}
