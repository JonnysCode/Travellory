import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/models/friends_model.dart';

class FriendManagement {
  static Future<HttpsCallableResult> sendFriendRequest(
      String uidSender, String uidReceiver) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'friends-sendFriendRequest',
    );
    return callable.call({'uidSender': uidSender, 'uidReceiver': uidReceiver});
  }

  static Future<HttpsCallableResult> acceptFriendRequest(
      String uidSender, String uidReceiver) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'friends-acceptFriendRequest',
    );
    return callable.call({'uidSender': uidSender, 'uidReceiver': uidReceiver});
  }

  static Future<HttpsCallableResult> declineFriendRequest(
      String uidSender, String uidReceiver) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'friends-declineFriendRequest',
    );
    return callable.call({'uidSender': uidSender, 'uidReceiver': uidReceiver});
  }

  static Future<HttpsCallableResult> removeFriend(
      String uidA, String uidB) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'friends-removeFriend',
    );
    return callable.call({'uidA': uidA, 'uidB': uidB});
  }

  static Future<List<FriendsModel>> getFriends(String uid) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'friends-getFriends',
    );
    final result = await callable.call({'uid': uid});
    List<FriendsModel> friendsList = List();
    for (String uid in result.data) {
      FriendsModel friend = await getPublicUserInformation(uid);
      friendsList.add(friend);
    };
    return friendsList;
  }

  static Future<List<FriendsModel>> getFriendRequests(String uid) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'friends-getFriendRequests',
    );
    final result = await callable.call({'uid': uid});
    List<FriendsModel> friendsList = List();
    for (String uid in result.data) {
      FriendsModel friend = await getPublicUserInformation(uid);
      friendsList.add(friend);
    };
    return friendsList;
  }

  static Future<FriendsModel> getPublicUserInformation(String uid) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-getPublicUserInformation',
    );
    final result = await callable.call({'uid': uid});
    FriendsModel friend =
        FriendsModel(result.data['uid'], result.data['displayName']);
    return friend;
  }
}
