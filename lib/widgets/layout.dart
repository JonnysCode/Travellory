import 'package:flutter/material.dart';

Widget mainPageLayout(BuildContext context, double layoutHeight, Widget page){

  return Container(
    child: Column(
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
                //TODO: travellory icon
                color: Theme.of(context).scaffoldBackgroundColor,
                height:layoutHeight * 0.95,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}