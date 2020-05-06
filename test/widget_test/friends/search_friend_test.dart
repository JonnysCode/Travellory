import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/screens/friends/search_friend_page.dart';
import 'package:travellory/services/authentication/auth.dart';

class MockAuth extends Mock implements BaseAuthService {}

void main() {
  Widget makeTestableWidget({Widget child}) {
    return MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(value: MockAuth().user),
          ChangeNotifierProvider<FriendsProvider>(
              create: (context) => FriendsProvider()
          ),
        ],
        child: MaterialApp(
          home: child,
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
    var backIcon = find.byIcon(FontAwesomeIcons.arrowLeft);

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
    var searchIcon = find.byIcon(FontAwesomeIcons.search);

    // Verify that a search Icon, cancel text and hint text is present.
    expect(textAddFriends, findsNWidgets(2));
    expect(textCancel, findsOneWidget);
    expect(searchIcon, findsOneWidget);
  });

  testWidgets('test if sent_friend_requests_list is present', (WidgetTester tester) async {
    SearchFriendsPage page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));
    var successText = find.text('Success');

    // Verify that the friends_request_list page is present.
    expect(successText, findsOneWidget);
  });



}
