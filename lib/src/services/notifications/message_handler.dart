import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/providers/friends_provider.dart';
import 'package:travellory/src/services/authentication/auth.dart';
import 'package:travellory/src/services/cloud/friend_management.dart';

class MessageHandler {
  static void configure(BuildContext context) async {
    final FirebaseMessaging _fcm = FirebaseMessaging();

    // get the current user
    final FirebaseUser user = await AuthService().getCurrentUser();

    // save the device token to the database
    final String fcmToken = await _fcm.getToken();
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'token-saveDeviceToken',
    );
    await callable.call({'uid': user.uid, 'token': fcmToken});

    // configure the callbacks
    _fcm.configure(
      onMessage: (Map<String, dynamic> message) async {
        _showNotification(message['notification']['title'],
            message['notification']['body'], context);
        updateFriendsProvider(context);
      },
      onLaunch: (Map<String, dynamic> message) async {
        updateFriendsProvider(context);
      },
      onResume: (Map<String, dynamic> message) async {
        updateFriendsProvider(context);
      },
    );
  }

  static void updateFriendsProvider(BuildContext context) {
    final FriendsProvider friendsProvider =
    Provider.of<FriendsProvider>(context, listen: false);
    friendsProvider.update(SocialActionType.receivedFriendRequest);
  }
}

Widget _showNotification(String title, String body, BuildContext context) {
  return SnackBar(
    content: Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        flushbarPosition: FlushbarPosition.TOP,
        title: title,
        message: body,
        icon: const Icon(Icons.person_add),
        backgroundColor: Colors.lightBlueAccent,
        margin: EdgeInsets.all(8),
        borderRadius: 12,
        duration: Duration(seconds: 4))
      ..show(context),
  );
}
