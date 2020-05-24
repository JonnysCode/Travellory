import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/friend_model.dart';
import 'package:travellory/screens/friends/friends_profile.dart';

void main() {
  Future<void> pumpArgumentWidget(
    WidgetTester tester, {
    @required Object args,
    @required Widget child,
  }) async {
    final key = GlobalKey<NavigatorState>();
    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: key,
        home: FlatButton(
          onPressed: () => key.currentState.push(
            MaterialPageRoute<void>(
              settings: RouteSettings(arguments: args),
              builder: (_) => child,
            ),
          ),
          child: const SizedBox(),
        ),
      ),
    );
  }

  testWidgets('test profile page', (WidgetTester tester) async {
    FriendsProfile page = FriendsProfile();
    FriendModel friend = FriendModel('uidFriend', 'friendName', null, '');

    final List<Object> args = [];
    args.add(friend);
    args.add(Achievements());

    await pumpArgumentWidget(tester, args: args, child: page);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();

    // expect page visible
    expect(find.byKey(Key('friends_profile')), findsOneWidget);
  });

  testWidgets('test if trips visible', (WidgetTester tester) async {
    FriendsProfile page = FriendsProfile();
    FriendModel friend = FriendModel('uidFriend', 'friendName', null, '');

    final List<Object> args = [];
    args.add(friend);
    args.add(Achievements());

    await pumpArgumentWidget(tester, args: args, child: page);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();

    // expect trips visible
    expect(find.byKey(Key('friends_trips')), findsOneWidget);
  });

  testWidgets('test if achievements visible', (WidgetTester tester) async {
    FriendsProfile page = FriendsProfile();
    FriendModel friend = FriendModel('uidFriend', 'friendName', null, '');

    final List<Object> args = [];
    args.add(friend);
    args.add(Achievements());

    await pumpArgumentWidget(tester, args: args, child: page);
    await tester.tap(find.byType(FlatButton));
    await tester.pumpAndSettle();

    // expect trips visible
    expect(find.byKey(Key('friends_achievements')), findsOneWidget);
  });
}
