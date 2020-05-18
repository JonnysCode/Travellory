import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'friends_profile_picture.dart';

void _openFriendsProfile(BuildContext context, FriendsModel friend){
  Navigator.pushNamed(context, '/friends/friends_profile', arguments: friend);
}

@override
Widget friendsCard(BuildContext context, FriendsModel friend, Widget button,
    double topPadding) {
  const double cardSize = 70;

  return Container(
    height: cardSize,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 20,
          right: 0,
          child: GestureDetector(
              onTap: () => _openFriendsProfile(context, friend),
            child: Container(
              height: cardSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xBBCCD7DD),
              ),
              padding: const EdgeInsets.only(
                  left: 65.0, top: 10.0, bottom: 14.0, right: 14.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FashionFetishText(
                          text: friend.username,
                          size: 18.0,
                          fontWeight: FashionFontWeight.heavy,
                          height: 1.1,
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.home,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 3),
                              child: FashionFetishText(
                                text: 'Switzerland',
                                size: 13.0,
                                fontWeight: FashionFontWeight.heavy,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15, top: topPadding),
                    child: button,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: friend.photoURL != null
                ? profilePicture(friend.photoURL, cardSize: cardSize)
                : standardPicture(cardSize: cardSize)
        ),
      ],
    ),
  );
}