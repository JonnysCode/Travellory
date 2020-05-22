import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friend_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/screens/friends/friends_list_page.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/services/authentication/auth.dart';

class MockFriendsProvider extends Mock implements FriendsProvider {}
class MockAuth extends Mock implements AuthService {}

void main() {
  Widget makeTestableWidget({Widget child}) {
    UserModel user = UserModel(uid: 'uidUser');
    FriendModel friend = FriendModel('uidFriend', 'friendName', null, '');
    FriendsProvider friendsProvider = MockFriendsProvider();

    when(friendsProvider.user).thenReturn(user);
    when(friendsProvider.isFetchingFriends).thenReturn(false);
    when(friendsProvider.isFetchingFriendRequests).thenReturn(false);
    when(friendsProvider.friends).thenReturn([friend]);
    when(friendsProvider.friendRequests).thenReturn([friend]);

    return MultiProvider(providers: [
          ChangeNotifierProvider<FriendsProvider>.value(value: friendsProvider),
          StreamProvider<UserModel>.value(value: MockAuth().user),
        ], child: MaterialApp(home: child));
  }

  testWidgets('test if friend_requests_list is present',
      (WidgetTester tester) async {
    FriendListPage page = FriendListPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the friends_request_list page is present.
    expect(find.byKey(Key('friend-requests-list')), findsOneWidget);
  });

  testWidgets('test if friends_list is present', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the friends_request_list page is present.
    expect(find.byKey(Key('friends-list')), findsOneWidget);
  });

  testWidgets('test if buttons for friends requests are present',
      (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the buttons for friends_request_list is present.
    expect(find.byKey(Key('accept_button')), findsOneWidget);
    expect(find.byKey(Key('decline_button')), findsOneWidget);
  });

  testWidgets('test if button for removing friends',
      (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the button for friend_list is present.
    expect(find.byKey(Key('remove_button')), findsOneWidget);
  });
}
