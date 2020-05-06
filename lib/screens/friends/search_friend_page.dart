import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/services/friends/friend_management.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_card_widget.dart';
import 'package:travellory/shared/loading_heart.dart';

class SearchFriendsPage extends StatefulWidget {
  @override
  _SearchFriendsPageState createState() => _SearchFriendsPageState();
}

class _SearchFriendsPageState extends State<SearchFriendsPage> {
  final _loading = List();

  void _sendFriendRequest(
      String uidSender, String uidReceiver, int index) async {
    String message;
    bool success;

    setState(() {
      _loading[index] = true;
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
      _loading[index] = false;
    });
    _showSnackBar(message, success);
  }

  Widget sendFriendRequestButton(
      String uidSender, String uidReceiver, int index) {
    return Wrap(
      children: <Widget>[
        socialButton(Key('send_request_button'), Icons.person_add, Colors.green,
            () => _sendFriendRequest(uidSender, uidReceiver, index)),
      ],
    );
  }

  Widget removeFriendRequestButton(String uidSender, String uidReceiver, int index) {
    return Wrap(
      children: <Widget>[
        socialButton(
            Key('remove_button'),
            Icons.clear,
            Colors.red,
            // TODO(hessgia1): call function to remove friend-request
            () => {},
        ),
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
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Material(
                    child: IconButton(
                      onPressed: () => Provider.of<FriendsPageProvider>(context,
                              listen: false)
                          .toggleSearching(),
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                      iconSize: 28,
                      color: Colors.black38,
                    ),
                  ),
                  FashionFetishText(
                    text: 'Add friends',
                    size: 22,
                    fontWeight: FashionFontWeight.heavy,
                  ),
                ])),
            Expanded(
              flex: 7,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                    right: 20,
                  ),
                  child: Material(
                    child: SearchBar(
                        key: Key('search_bar'),
                        onSearch: search,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 10,
                        onItemFound: (FriendsModel friend, int index) {
                          _loading.add(false);
                          return friendsCard(
                              context,
                              friend,
                              _loading[index]
                                  ? CircularProgressIndicator()
                                  : sendFriendRequestButton(
                                  user.uid, friend.uid, index),
                              10
                          );
                        },
                        loader: LoadingHeart(),
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
                        ),
                    ),
                  ),
                ),
            ),
            SizedBox(height: 20),
            Padding(
              key: Key('sent_friend_requests'),
              padding: EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 90,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Sent friend requests',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey
                  ),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              indent: 25,
              endIndent: 25,
              color: Colors.grey,
            ),
            Expanded(
              flex: 3,
              child: Padding(
                key: Key('sent_friend_requests_list'),
                padding: EdgeInsets.only(
                    left: 15,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Scrollbar(
                    child: Consumer<FriendsProvider>(
                      builder: (_, friendsProvider, __) => friendsProvider.isFetching
                          ? LoadingHeart()
                          // TODO(hessgia1): replace friends with friend-request-list
                          : friendsProvider.friends.isEmpty
                          ? Text('You have sent no friend requests :(')
                          : ListView.separated(
                              padding: EdgeInsets.only(
                                bottom: 30,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                const SizedBox(height: 12),
                              // TODO(hessgia1): replace friends with friend-request-list
                              itemCount: friendsProvider.friends.length,
                              itemBuilder: (context, index) {
                                // TODO(hessgia1): replace friends with friend-request-list
                                final friend = friendsProvider.friends[index];
                                _loading.add(false);
                                return friendsCard(
                                  context,
                                  friend,
                                  _loading[index]
                                      ? CircularProgressIndicator()
                                      : removeFriendRequestButton(
                                      friend.uid, user.uid, index),
                                  10
                                );
                              },
                          ),
                    )
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        )
    );
  }
}
