import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'friends_profile_header.dart';

class FriendsProfile extends StatelessWidget {
  const FriendsProfile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FriendsModel friendsModel = Provider.of(context, listen: false).selectedFriend.friendsModel;

    return Scaffold(
      key: Key('friends_profile'),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FriendsProfileHeader(friendsModel),
          ],
        ),
      ),
    );
  }
}