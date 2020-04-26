import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/screens/friends/friends_list_page_dev.dart';
import 'package:travellory/screens/friends/search_friend_page.dart';
import 'package:travellory/screens/friends/friends_list_page.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  bool _dev;

  @override
  void initState() {
    super.initState();
    _dev = true;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FriendsPageProvider>(
      create: (_) => FriendsPageProvider(),
      child: SafeArea(
          child: Container(
              key: Key('friends_page'),
              child: SizedBox.expand(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
                  child: Container(
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
                    child: Selector<FriendsPageProvider, bool>(
                      selector: (_, friendsPageProvider) => friendsPageProvider.isSearching,
                      builder: (_, isSearching, __) => isSearching
                          ? Container(child: SearchFriendsPage()) // TODO Fix that both pages on the friendspage
                          : Container(child: _dev
                            ? Container(child: FriendListPageDev())
                            : Container(child: FriendListPage())),
                    )
                  ),
                ),
              )
          )
      ),
    );
  }
}