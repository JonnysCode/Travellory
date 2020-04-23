import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/widgets/font_widgets.dart';


@override
Widget friendsCard(BuildContext context, List<FriendsModel> list, int index) {
  return Container(
    height: 80,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 40,
          right: 0,
          child: GestureDetector(
//              TODO(fluetfab): link to profile-page of the friend
//              onTap: () => _openFriendsProfile(),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Color(0xBBCCD7DD),
              ),
              padding: const EdgeInsets.only(left: 50.0, top: 14.0, bottom: 14.0, right: 14.0),
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
                        FontAwesomeIcons.locationArrow,
                        size: 14,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 6, left: 3),
                        child: FashionFetishText(
                          text: 'Homecountry: ${list[index].username}',
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
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            height: 80,
            width: 80,
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

