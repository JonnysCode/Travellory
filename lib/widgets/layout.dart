import 'package:flutter/material.dart';

Widget mainPageLayout(BuildContext context, double layoutHeight, Widget page){

  return Stack(
    children: <Widget>[
      Column(
        children: <Widget>[
          SizedBox(
            height: layoutHeight * 0.05,
          ),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
              boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(.1), offset: Offset(0.0, -6.0))],
            ),
            child: page,
            height:layoutHeight * 0.95,
            width: MediaQuery.of(context).size.width,
          ),
        ],
      ),
      Positioned(
        top: 15,
        left: 25,
          child: Image(
            image: AssetImage('assets/images/logo/travellory_icon.png'),
            height: 80,
          ),
      )
    ],
  );
}