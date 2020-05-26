import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/services/cloud/friend_management.dart';

void main() {
  MethodCall logMethodCall;
  const uidSender = 'uidSender';
  const uidReceiver = 'uidReceiver';

  // mock the cloud functions channel
  MethodChannel channel =
      const MethodChannel('plugins.flutter.io/cloud_functions');

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    // register the mock handler
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      logMethodCall = methodCall;
    });
  });

  tearDown(() {
    // unregister the mock handler
    channel.setMockMethodCallHandler(null);
  });

  test('test send friend request', () async {
    const SocialActionType type = SocialActionType.sendFriendRequest;
    const parameters = {'uidSender': uidSender, 'uidReceiver': uidReceiver};

    await FriendManagement().performSocialAction(uidSender, uidReceiver, type);

    expect(logMethodCall.arguments['functionName'],
        equals(FriendManagement().getFunctionName(type)));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test accept friend request', () async {
    const SocialActionType type = SocialActionType.acceptFriendRequest;
    const parameters = {'uidSender': uidSender, 'uidReceiver': uidReceiver};

    await FriendManagement().performSocialAction(uidSender, uidReceiver, type);

    expect(logMethodCall.arguments['functionName'],
        equals(FriendManagement().getFunctionName(type)));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test decline friend request', () async {
    const SocialActionType type = SocialActionType.declineFriendRequest;
    const parameters = {'uidSender': uidSender, 'uidReceiver': uidReceiver};

    await FriendManagement().performSocialAction(uidSender, uidReceiver, type);

    expect(logMethodCall.arguments['functionName'],
        equals(FriendManagement().getFunctionName(type)));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test remove friend', () async {
    const SocialActionType type = SocialActionType.removeFriend;
    const parameters = {'uidSender': uidSender, 'uidReceiver': uidReceiver};

    await FriendManagement().performSocialAction(uidSender, uidReceiver, type);

    expect(logMethodCall.arguments['functionName'],
        equals(FriendManagement().getFunctionName(type)));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test get friends', () async {
    const parameters = {'uid': uidSender};

    await FriendManagement().getFriends(uidSender);

    expect(
        logMethodCall.arguments['functionName'], equals('friends-getFriends'));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test get friend requests', () async {
    const parameters = {'uid': uidSender};

    await FriendManagement().getFriendRequests(uidSender);

    expect(logMethodCall.arguments['functionName'],
        equals('friends-getFriendRequests'));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test get sent friend requests', () async {
    const parameters = {'uid': uidSender};

    await FriendManagement().getFriendRequests(uidSender);

    expect(logMethodCall.arguments['functionName'],
        equals('friends-getFriendRequests'));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });

  test('test search by username', () async {
    const String username = 'username';
    const parameters = {'displayName': username};

    await FriendManagement().searchByUsername(username);

    expect(logMethodCall.arguments['functionName'],
        equals('user-searchByUsername'));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });
}
