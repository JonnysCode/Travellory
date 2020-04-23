import 'package:flutter/material.dart';
import 'package:travellory/screens/friends/search_friend_page.dart';
import 'package:travellory/screens/friends/friends_list_page.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  bool _isSearching;

  @override
  void initState() {
    super.initState();
    _isSearching = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            key: Key('friends_page'),
            child: Stack(
                children: <Widget>[
                  SizedBox.expand(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
                      child: Container(
                          child: _isSearching
                              ? Container(child: SearchFriendsPage()) // TODO Fix that both pages on the friendspage
                              : Container(child: FriendListPage())
                      ),
                    ),
                  ),
                ]
            )
        )
    );
  }
}