import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/friends_model.dart';

class FriendsProfileHeader extends StatefulWidget {
  const FriendsProfileHeader({Key key, this.friend}) : super(key: key);

  final friend;

//  final FriendsModel friend;

  @override
  _FriendsHeaderState createState() => _FriendsHeaderState();
}

class _FriendsHeaderState extends State<FriendsProfileHeader> {
//  get friend => null;

//  FriendsModel _friendsModel;

  @override
  Widget build(BuildContext context) {
//    _friendsModel = widget.friendsModel;

    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
        color: Color(0xFFCCD7DD),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: FaIcon(FontAwesomeIcons.times),
              iconSize: 26,
              color: Colors.red,
            ),
          ),
          Positioned(
            top: -30,
            left: -40,
            child: Hero(
//              tag: 'friend_image${_friendsModel.index.toString()}',
              child: Container(
                height: 220,
                width: 220,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(widget.friend.photoURL),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 180,
            child: Container(
              padding: EdgeInsets.only(top: 40, left: 10, right: 10),
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                  maxHeight: 100.0,
                  maxWidth: MediaQuery.of(context).size.width - 200
              ),
              child: Text(
                widget.friend.username,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'FashionFetish',
                    fontSize: 22,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2
                ),
              ),
            ),
          ),
          Positioned(
            top: 100,
            left: 190,
            right: 10,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.home,
                      size: 15,
                      color: Colors.redAccent,
                    ),
                    SizedBox(
                      width: 6,
                    ),
//                    SizedBox(
//                      width: 160,
//                      child: Text(
//                        _friendsModel.hometown,
//                        overflow: TextOverflow.ellipsis,
//                        maxLines: 2,
//                        style: TextStyle(
//                            fontFamily: 'FashionFetish',
//                            fontSize: 13,
//                            height: 1.15,
//                            fontWeight: FontWeight.w900,
//                            letterSpacing: -1,
//                            color: Colors.black54
//                        ),
//                      ),
//                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}