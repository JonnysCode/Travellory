import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/services/friends/friend_management.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_card_widget.dart';

class SearchFriendsPage extends StatefulWidget {
  @override
  _SearchFriendsPageState createState() => _SearchFriendsPageState();
}

class _SearchFriendsPageState extends State<SearchFriendsPage> {
  bool _loading = false;

  void _sendFriendRequest(String uidSender, String uidReceiver) async {
    String message;
    bool success;

    setState(() {
      _loading = true;
    });

    if (uidSender == uidReceiver) {
      message = "You can't send a friend request to yourself";
      success = false;
    } else if (await FriendManagement.areFriends(uidSender, uidReceiver) ||
        await FriendManagement.friendRequestExists(uidSender, uidReceiver)) {
      message =
          "You are already friends with that person or a friend request has already been sent.";
      success = false;
    } else {
      await FriendManagement.performSocialAction(
              uidSender, uidReceiver, SocialActionType.sendFriendRequest)
          .then((value) async {
        message = "Friend request sent";
        success = true;
      }).catchError((error) {
        message = "There was an error. Try again.";
        success = false;
      });
    }
    setState(() {
      _loading = false;
    });
    _showSnackBar(message, success);
  }

  Widget sendFriendRequestButton(String uidSender, String uidReceiver) {
    return Wrap(
      children: <Widget>[
        socialButton(Key('send_request_button'), Icons.person_add, Colors.green,
            () => _sendFriendRequest(uidSender, uidReceiver)),
      ],
    );
  }

  Widget _showSnackBar(String message, bool success) {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: success ? "Success" : "Error",
          message: message,
          backgroundColor:
              success ? Theme.of(context).primaryColor : Colors.redAccent,
          margin: EdgeInsets.all(8),
          borderRadius: 12,
          duration: Duration(seconds: 3))
        ..show(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<FriendsModel>> search(String search) async {
    return FriendManagement.searchByUsername(search);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return SafeArea(
        key: Key('search_friends'),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Material(
                        child: IconButton(
                          onPressed: () =>
                            Provider.of<FriendsPageProvider>(context, listen: false)
                                .toggleSearching(),
                          icon: Icon(FontAwesomeIcons.arrowLeft),
                          iconSize: 28,
                          color: Colors.black38,
                        ),
                      ),
                  FashionFetishText(
                    text: 'Add Friends',
                    size: 22,
                    fontWeight: FashionFontWeight.heavy,
                  ),
            ])),
            Expanded(
              child: Material(
                child: SearchBar(
                    key: Key('search_bar'),
                    onSearch: search,
                    onItemFound: (FriendsModel friend, int index) {
                      return Padding(
                          padding: EdgeInsets.only(
                            bottom: 10,
                          ),
                          child: friendsCard(
                              context,
                              friend,
                              _loading
                                  ? CircularProgressIndicator()
                                  : sendFriendRequestButton(user.uid, friend.uid),
                              10));
                    },
                    loader: Loading(),
                    searchBarPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    headerPadding: EdgeInsets.symmetric(horizontal: 50),
                    listPadding: EdgeInsets.symmetric(horizontal: 30),
                    hintText: 'Add friends',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    icon: Icon(
                      FontAwesomeIcons.search,
                      size: 24.0,
                    ),
                    iconActiveColor: Colors.black54,
                    searchBarStyle: SearchBarStyle(
                      backgroundColor: Colors.black12,
                      padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    cancellationWidget: Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              )
            ),
          ],
        ));
  }
}
