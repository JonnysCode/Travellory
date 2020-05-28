import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget standardPicture({double cardSize}) {
  return Container(
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
  );
}
