import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget profilePicture(String photoURL, {double cardSize}) {
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
        errorWidget: (context, url, error) =>  standardPicture(cardSize: cardSize),
      ));
}

Widget standardPicture({double cardSize}) {
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