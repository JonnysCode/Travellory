import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

@override
Widget friendsCard(BuildContext context, FriendsModel friend, Widget button,
    double topPadding) {
  final double cardSize = 70;

  return Container(
    height: cardSize,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 20,
          right: 0,
          child: GestureDetector(
//            TODO (fluetfab): link to friends profile
//            onTap: () => _openFriendsProfile(),
            child: Container(
              height: cardSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xBBCCD7DD),
              ),
              padding: const EdgeInsets.only(
                  left: 65.0, top: 10.0, bottom: 14.0, right: 14.0),
              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                              color: Colors.brown,
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
                ? profilePicture(friend.photoURL, cardSize)
                : standardPicture(cardSize)
        ),
      ],
    ),
  );
}

Widget profilePicture(String photoURL, double cardSize) {
  return Container(
      height: cardSize,
      width: cardSize,
      child: CachedNetworkImage(
        /// will check local cache first and download from firebase if necessary
        imageUrl: photoURL,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  blurRadius: 6,
                  color: Colors.black.withOpacity(.3),
                  offset: Offset(3.0, 3.0))
            ],
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.fitWidth,
              alignment: Alignment.bottomCenter,
            ),
            border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
          ),
        ),
        placeholder: (context, url) => CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
        errorWidget: (context, url, error) =>  standardPicture(cardSize),
      ));
}

Widget standardPicture(double cardSize) {
  return Container(
    height: cardSize,
    width: cardSize,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      boxShadow: <BoxShadow>[
        BoxShadow(
            blurRadius: 6,
            color: Colors.black.withOpacity(.3),
            offset: Offset(3.0, 3.0))
      ],
      image: DecorationImage(
        image: AssetImage("assets/images/login/beach.png"),
        fit: BoxFit.fitWidth,
        alignment: Alignment.bottomCenter,
      ),
    ),
  );
}
