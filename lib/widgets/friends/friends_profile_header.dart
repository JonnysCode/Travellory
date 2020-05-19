import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'friends_profile_picture.dart';

class FriendsProfileHeader extends StatefulWidget {
  const FriendsProfileHeader({Key key, this.friend, double headerSize}) : super(key: key);

  final friend;
  final double headerSize = 140;

  @override
  _FriendsHeaderState createState() => _FriendsHeaderState();
}

class _FriendsHeaderState extends State<FriendsProfileHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.headerSize,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(widget.headerSize/2)),
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
            child: Hero(
              tag: widget.friend.uid,
              child: Container(
                height: widget.headerSize,
                width: widget.headerSize,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(widget.headerSize/2)),
                ),
                child: widget.friend.photoURL != null
                    ? profilePicture(widget.friend.photoURL)
                    : standardPicture(),
              ),
            ),
          ),
          Positioned(
            left: widget.headerSize + 20,
            child: Container(
              padding: EdgeInsets.only(top: 50, left: 10, right: 10),
              alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              constraints: BoxConstraints(
                  maxHeight: 100.0,
                  maxWidth: MediaQuery.of(context).size.width - 200),
              child: Text(
                widget.friend.username,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                    fontFamily: 'FashionFetish',
                    fontSize: 22,
                    height: 1.1,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -2),
              ),
            ),
          ),
          Positioned(
            top: 85,
            left: widget.headerSize + 30,
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
                      color: Theme.of(context).primaryColor,
                    ),
                    SizedBox(
                      width: 6,
                    ),
                    SizedBox(
                      width: 160,
                      child: Text(
                        widget.friend.hometown == '' ? 'N/A' : widget.friend.hometown,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: 'FashionFetish',
                            fontSize: 14,
                            height: 1.15,
                            fontWeight: FontWeight.w900,
                            letterSpacing: -1,
                            color: Colors.black54
                        ),
                      ),
                    ),
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
