import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/screens/friends/friends_list_page.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/services/authentication/auth.dart';

class MockAuth extends Mock implements BaseAuthService {}
class MockFriendsProvider extends Mock implements FriendsProvider {}
class MockUserModel extends Mock implements UserModel {}
class FakeAuth extends Fake implements AuthService {
  final userModel = UserModel(uid: 'uid', displayName: 'name');

  @override
  Stream<UserModel> get user {
    return Stream<UserModel>.value(userModel);
  }

  @override
  Future getCurrentUser() async {
    return userModel;
  }
}

void main() {
  Widget makeTestableWidget({Widget child}) {
    FriendsModel friend = FriendsModel('uidFriend', 'friendName', null);
    FriendsProvider friendsProvider = MockFriendsProvider();

    MockAuth mockAuth = MockAuth();
    UserModel user = UserModel(uid: 'uid', displayName: 'name');

    when(friendsProvider.isFetching)
        .thenReturn(false);
    when(friendsProvider.friends)
        .thenReturn([friend]);
    when(friendsProvider.friendRequests)
        .thenReturn([friend]);
    when(mockAuth.user)
        .thenAnswer((_) => Stream<UserModel>.value(user));



    return MultiProvider(
        providers: [
          ChangeNotifierProvider<FriendsProvider>.value(
              value: friendsProvider
          ),
          StreamProvider<UserModel>.value(
              value: FakeAuth().user
          ),
        ],
        child: MaterialApp(
            home: child
        ));
  }

  testWidgets('test if friend_requests_list is present', (WidgetTester tester) async {
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

  testWidgets('test if buttons for friends requests are present', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the buttons for friends_request_list is present.
    expect(find.byKey(Key('accept_button')), findsOneWidget);
    expect(find.byKey(Key('decline_button')), findsOneWidget);
  });

  testWidgets('test if button for removing friends', (WidgetTester tester) async {
    FriendsPage page = FriendsPage();

    // Build our app and trigger a frame.
    await tester.pumpWidget(makeTestableWidget(child: page));

    // Verify that the button for friend_list is present.
    expect(find.byKey(Key('remove_button')), findsOneWidget);
  });

}
