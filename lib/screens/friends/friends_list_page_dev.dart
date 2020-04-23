import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/friends/friends_list_widget.dart';

class FriendListPageDev extends StatefulWidget {
  @override
  _FriendListPageDevState createState() => _FriendListPageDevState();
}

class _FriendListPageDevState extends State<FriendListPageDev> {
  final List<FriendsModel> friendRequests = [];
  final List<FriendsModel> friends = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      //TODO(hessgia1): create dynamic list according to logged in user.
      friendRequests
        ..add(FriendsModel("1", "doejohn"))
        ..add(FriendsModel("2", "doejane"))
        ..add(FriendsModel("3", "doejames",))
        ..add(FriendsModel("4", "doejessy",))
        ..add(FriendsModel("5", "doejason",));

      friends
        ..add(FriendsModel("11", "hessgia1"))
        ..add(FriendsModel("12", "schinsev"))
        ..add(FriendsModel("13", "grussjon"))
        ..add(FriendsModel("14", "bertaben"))
        ..add(FriendsModel("15", "stadena1"))
        ..add(FriendsModel("16", "antilyas"))
        ..add(FriendsModel("17", "gubleet1"))
        ..add(FriendsModel("18", "isztldav"));
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
              offset: Offset(0.0, -6.0))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(
              FontAwesomeIcons.addressBook,
              size: 50,
            ),
            Text(
              'FRIENDS',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, '/search_friends'),
              },
              child: Icon(
                FontAwesomeIcons.search,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
            ),
          ]),
          SizedBox(height: 20),
          Padding(
            key: Key('friend_requests'),
            padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 90,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Friend requests',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          friendList(
              Key('friend_requests_list'),
              145,
              friendRequests,
              Wrap(
                children: <Widget>[
                  socialButton(
                      Key('accept_button'),
                      Icons.add_circle,
                      Colors.green,
                      null),
                  socialButton(
                      Key('decline_button'),
                      Icons.remove_circle,
                      Colors.red,
                      null),
                ],
              ),
              context),
          SizedBox(height: 40),
          Padding(
            key: Key('friends'),
            padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 90,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              height: 30,
              width: MediaQuery.of(context).size.width,
              child: Text(
                'Friends',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          friendList(
              Key('friends_list'),
              225,
              friends,
              Wrap(
                children: <Widget>[
                  socialButton(
                      Key('remove_button'),
                      Icons.remove_circle,
                      Colors.red,
                      null),
                ],
              ),
              context),
        ],
      ),
    );
  }
}