import 'package:flutter/material.dart';
import 'package:travellory/widgets/buttons.dart';

import '../font_widgets.dart';

Container bottomBar(
  BuildContext context,
) {
  void _edit() {
    // TODO
  }

  void _delete() {
    // TODO
  }

  return Container(
    padding: EdgeInsets.all(20.0),
    height: 130.0,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        filledButton('EDIT', Colors.white, Theme.of(context).primaryColor,
            Theme.of(context).primaryColor, Colors.white, _edit),
        filledButton('DELETE', Colors.white, Theme.of(context).primaryColor,
            Theme.of(context).primaryColor, Colors.white, _delete),
      ],
    ),
  );
}

Padding fieldView(IconData icon, String title, String details, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(children: <Widget>[
        SizedBox(width: 30.0),
        Icon(
          icon,
          size: 40.0,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FashionFetishText(
                text: title,
                size: 15.0,
                fontWeight: FashionFontWeight.bold,
                color: Colors.black54),
            Text(
              details,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ]));
}
