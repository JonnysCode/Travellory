import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';
import '../font_widgets.dart';
import 'friends_profile_header.dart';

class FriendsProfile extends StatefulWidget {
  FriendsProfile({
    Key key,
  }) : super(key: key);

  @override
  _FriendsProfileState createState() => _FriendsProfileState();
}

class _FriendsProfileState extends State<FriendsProfile> {
  @override
  Widget build(BuildContext context) {
    final FriendsModel friend = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Key('friends_profile'),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            FriendsProfileHeader(friend: friend),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                    child: FashionFetishText(
                      text: 'Trips of ${friend.username}' ,
                      size: 22,
                      fontWeight: FashionFontWeight.heavy,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 300),
            Container(
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 20,
                    ),
                    child: FashionFetishText(
                      text: 'Achievements of ${friend.username}',
                      size: 22,
                      fontWeight: FashionFontWeight.heavy,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
