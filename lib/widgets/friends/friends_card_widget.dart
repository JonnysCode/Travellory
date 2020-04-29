import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

@override
Widget friendsCard(BuildContext context, List<FriendsModel> list, Widget button, double topPadding, int index) {
  double cardSize = 70;

  return Container(
    height: cardSize,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 20,
          right: 0,
          child: GestureDetector(
//              TODO(fluetfab): link to profile-page of the friend
//              onTap: () => _openFriendsProfile(),
            child: Container(
              height: cardSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xBBCCD7DD),
              ),
              padding: const EdgeInsets.only(left: 65.0, top: 10.0, bottom: 14.0, right: 14.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FashionFetishText(
                          text: '${list[index].username}',
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
                    padding: EdgeInsets.only(
                        right: 15,
                        top: topPadding
                    ),
                    child: button,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: cardSize,
            width: cardSize,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              boxShadow: <BoxShadow>[
                BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.3), offset: Offset(3.0, 3.0))
              ],
              image: DecorationImage(
                image: AssetImage("assets/images/login/beach.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

