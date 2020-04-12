import 'package:flutter/material.dart';
import 'package:travellory/widgets/buttons.dart';

Container bottomBar(BuildContext context, ) {
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

Row fieldView(IconData icon, String title, String details, BuildContext context) {
  return Row(children: <Widget>[
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
        Text(
          title,
          style: TextStyle(fontSize: 16.0),
        ),
        Text(
          details,
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    ),
  ]);
}