import 'package:flutter/material.dart';

Widget filledButton(String text, Color splashColor, Color highlightColor, Color fillColor,
    Color textColor, void function()) {
  return RaisedButton(
    key: Key(text.toLowerCase().trim() + 'Button'),
    highlightElevation: 0.0,
    splashColor: splashColor,
    highlightColor: highlightColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
    ),
    onPressed: () => function(),
  );
}

Widget alertButton(String text, Color fillColor, BuildContext context, void function()) {
  return RaisedButton(
    key: Key(text.toLowerCase().trim() + 'Button'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: Theme.of(context).primaryColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
    ),
    onPressed: () => function(),
  );
}

Widget cancelButton(String text, BuildContext context, void function()) {
  return RaisedButton(
    key: Key(text.toLowerCase().trim() + 'Button'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: Theme.of(context).primaryColor,
    elevation: 0.0,
    color: Theme.of(context).accentColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
    ),
    onPressed: () => function(),
  );
}

Widget submitButton(BuildContext context, Color highlightColor, Color fillColor, bool validatedFunction(), void function()) {
  return RaisedButton(
    key: Key('SubmitButton'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: highlightColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      "SUBMIT",
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
    ),
    onPressed: () {
      if (validatedFunction()) {
        function();
      }
      else {
        cancelButton("CANCEL", context, () {
          });
      }
    }
  );
}