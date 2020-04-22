import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/friends_list_widget.dart';

class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {

  List<FriendsModel> friendRequests = [];
  final List<FriendsModel> friends = [];

  @override
  void initState(){
    super.initState();
    setState(() {
      //TODO(hessgia1): create dynamic list according to logged in user

      friends..add(FriendsModel(
          "11",
          "hessgia1"
      ));
      friends..add(FriendsModel(
          "12",
          "schinsev"
      ));
      friends..add(FriendsModel(
          "13",
          "grussjon"
      ));
      friends..add(FriendsModel(
          "14",
          "bertaben"
      ));
      friends..add(FriendsModel(
          "15",
          "stadena1"
      ));
      friends..add(FriendsModel(
          "16",
          "antilyas"
      ));
      friends..add(FriendsModel(
          "17",
          "gubleet1"
      ));
      friends..add(FriendsModel(
          "18",
          "isztldav"
      ));
    });
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
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 20),
                      Text(
                        'FRIENDS',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                      Consumer<FriendsProvider>(
                        builder: (_, friendsProvider, __ ) => friendsProvider.isFetching
                            ? Loading()
                            : friendsProvider.friends.isEmpty
                              ? Text('You have no friend requests :(')
                              : friendList(
                            Key('friend_requests_list'),
                            145,
                            friendsProvider.friendRequests,
                            Wrap(
                              children: <Widget>[
                                socialButton(
                                    Key('accept_button'),
                                    Icons.add_circle,
                                    Colors.green,
                                    null
                                ),
                                socialButton(
                                    Key('decline_button'),
                                    Icons.remove_circle,
                                    Colors.red,
                                    null
                                ),
                              ],
                            ),
                            context
                        ),
                      ),
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
                      Consumer<FriendsProvider>(
                        builder: (_, friendsProvider, __ ) => friendsProvider.isFetching
                            ? Loading()
                            : friendsProvider.friends.isEmpty
                              ? Text('You have no friends :(')
                              : friendList(
                            Key('friends_list'),
                            225,
                            friendsProvider.friends,
                            Wrap(
                              children: <Widget>[
                                socialButton(
                                    Key('remove_button'),
                                    Icons.remove_circle,
                                    Colors.red,
                                    null
                                ),
                              ],
                            ),
                            context
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 30,
              child: Icon(
                FontAwesomeIcons.addressBook,
                size: 50,
              ),
            ),
            Positioned(
              top: 50,
              right: 30,
              child: Icon(
                Icons.search,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}