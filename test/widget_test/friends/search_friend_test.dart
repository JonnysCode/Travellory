import 'dart:async';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friend_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/screens/friends/search_friend_page.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/services/friends/friend_management.dart';

class MockAuth extends Mock implements BaseAuthService {}

class MockFriendsProvider extends Mock implements FriendsProvider {}

class MockFriendManagement extends Mock implements FriendManagement {}

void main() {
  const String uidUser = 'uidUser';
  const String uidFriend = 'uidFriend';
  const String friendName = 'friendName';
  const String uidSearch = 'uidSearch';
  const String searchName = 'searchName';
  const String uidSent = 'uidSent';
  const String sentName = 'sentName';
  final FriendManagement friendManagement = MockFriendManagement();

  Widget makeTestableWidget({Widget child}) {
    UserModel user = UserModel(uid: uidUser);
    FriendModel friend = FriendModel(uidFriend, friendName, null, '');
    FriendModel search = FriendModel(uidSearch, searchName, null, '');
    FriendModel sent = FriendModel(uidSent, sentName, 'pic.jpg', '');
    FriendsProvider friendsProvider = MockFriendsProvider();

    // mock behavior of friendsProvider
    when(friendsProvider.user).thenReturn(user);
    when(friendsProvider.isFetchingFriends).thenReturn(false);
    when(friendsProvider.isFetchingFriendRequests).thenReturn(false);
    when(friendsProvider.isFetchingSentFriendRequests).thenReturn(false);
    when(friendsProvider.friends).thenReturn([friend]);
    when(friendsProvider.friendRequests).thenReturn([]);
    when(friendsProvider.sentFriendRequests).thenReturn([sent]);
    when(friendsProvider.management).thenReturn(friendManagement);

    // mock behavior of friendManagement
    var completer = Completer<HttpsCallableResult>();
    var future = completer.future;
    when(friendManagement.performSocialAction(any, any, any))
        .thenAnswer((_) => future);
    when(friendManagement.searchByUsername(searchName))
        .thenAnswer((_) => Future.value([search]));

    return MultiProvider(
        providers: [
          StreamProvider<UserModel>.value(value: MockAuth().user),
          ChangeNotifierProvider<FriendsProvider>.value(value: friendsProvider),
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

  testWidgets(
      'test if search by username called when entering text in search bar',
      (WidgetTester tester) async {
    SearchFriendsPage page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // enter text in the search bar
    Finder searchBar = find.byKey(Key('search_bar'));
    await tester.enterText(searchBar, searchName);
    await tester.pump(Duration(seconds: 1));

    // expect search by username called once with correct argument
    verify(friendManagement.searchByUsername(searchName)).called(1);
  });

  testWidgets(
      'test if send friend request button visible when found user is not friend already',
      (WidgetTester tester) async {
    SearchFriendsPage page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // enter text in the search bar
    Finder searchBar = find.byKey(Key('search_bar'));
    await tester.enterText(searchBar, searchName);
    await tester.pump(Duration(seconds: 1));

    // expect to find send request button
    expect(find.byKey(Key('send_request_button')), findsOneWidget);
  });

  testWidgets(
      'test if send friend request button not shown when found user is friend already',
      (WidgetTester tester) async {
    SearchFriendsPage page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // enter text in the search bar
    Finder searchBar = find.byKey(Key('search_bar'));
    await tester.enterText(searchBar, friendName);
    await tester.pump(Duration(seconds: 1));

    // expect not to find send request button
    expect(find.byKey(Key('send_request_button')), findsNothing);
  });

  testWidgets(
      'test if send friend request called when pressing friend request button',
      (WidgetTester tester) async {
    SearchFriendsPage page = SearchFriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // enter text in the search bar
    Finder searchBar = find.byKey(Key('search_bar'));
    await tester.enterText(searchBar, searchName);
    await tester.pump(Duration(seconds: 1));

    // press the send friend request button
    Finder requestButton = find.byKey(Key('send_request_button'));
    await tester.tap(requestButton);
    await tester.pump();

    // expect send friend request called once with correct arguments
    verify(friendManagement.performSocialAction(
            uidUser, uidSearch, SocialActionType.sendFriendRequest))
        .called(1);
  });

  testWidgets(
      'test if decline (withdraw) friend request called when pressing withdraw button',
          (WidgetTester tester) async {
        SearchFriendsPage page = SearchFriendsPage();

        // Build our app and trigger a frame.
        await tester.pumpWidget(makeTestableWidget(child: page));

        // press the withdraw friend request button
        Finder withdrawButton = find.byKey(Key('withdraw_button'));
        await tester.tap(withdrawButton);
        await tester.pump();

        // expect decline friend request called once with correct arguments
        verify(friendManagement.performSocialAction(
            uidUser, uidSent, SocialActionType.declineFriendRequest))
            .called(1);
      });
}
