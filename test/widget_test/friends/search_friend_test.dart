import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/friends/search_friend_page.dart';
import 'package:travellory/services/authentication/auth.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child}) {

    return MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(
              value: MockAuth().user
          ),
        ],
        child: Material(
            child: child
        ));
  }

  testWidgets('test if search friend page is present',
      (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that search friend page is active.
    expect(find.byKey(Key('search_friends')), findsOneWidget);
  });

  testWidgets('test if search friend page has searchbar',
      (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that search bar is present.
    expect(find.byKey(Key('search_bar')), findsOneWidget);
  });

  testWidgets('test if search friend page has back button',
      (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));
    var backIcon = find.byIcon(Icons.arrow_back);

    // Verify that page has arrow back.
    expect(backIcon, findsOneWidget);
  });

  testWidgets(
      'test if search friend page has searchIcon, Cancel Text, hintText',
      (WidgetTester tester) async {
    Widget page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));
    var textAddFriends = find.text('Add friends');
    var textCancel = find.text('Cancel');
    var searchIcon = find.byIcon(Icons.search);

    // Verify that a search Icon, cancel text and hint text is present.
    expect(textAddFriends, findsOneWidget);
    expect(textCancel, findsOneWidget);
    expect(searchIcon, findsOneWidget);
  });
}
