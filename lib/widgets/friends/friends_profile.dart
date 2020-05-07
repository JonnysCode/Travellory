import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';
import 'friends_profile_header.dart';

class FriendsProfile extends StatefulWidget {
  FriendsProfile({
    Key key, this.friend,
  }) : super(key: key);

  final FriendsModel friend;

  @override
  _FriendsProfileState createState() => _FriendsProfileState();
}

class _FriendsProfileState extends State<FriendsProfile> {


  @override
  Widget build(BuildContext context) {
//    final FriendsModel friendsModel = Provider.of(context, listen: false).selectedFriend.friendsModel;


    return Scaffold(
      key: Key('friends_profile'),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FriendsProfileHeader(friend: widget.friend),
          ],
        ),
      ),
    );
  }


}