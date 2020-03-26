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
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                child: Container(
                  child: page,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  height:layoutHeight * 0.95,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ),
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