import 'package:flutter/material.dart';
import '../shared/font_widgets.dart';

Widget filledButton(String text, Color splashColor, Color highlightColor, Color fillColor,
    Color textColor, void Function() function) {
  return RaisedButton(
    key: Key('${text.toLowerCase().trim()}Button'),
    highlightElevation: 0.0,
    splashColor: splashColor,
    highlightColor: highlightColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    onPressed: () => function(),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
    ),
  );
}

Widget alertButton(String text, Color fillColor, BuildContext context, void Function() function) {
  return RaisedButton(
    key: Key('${text.toLowerCase().trim()}Button'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: Theme.of(context).primaryColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    onPressed: () => function(),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
    ),
  );
}

Widget socialButton(Key key, IconData icon, Color color, void Function() function) {
  return Material(
    child: IconButton(
      key: key,
      padding: EdgeInsets.only(
        top: 0,
      ),
      alignment: Alignment.topRight,
      iconSize: 30,
      icon: Icon(
        icon,
        color: color,
      ),
      onPressed: () => function(),
    ),
  );
}

Widget roundedButton(String buttonLabel, EdgeInsets margin, Color bgColor, Color textColor) {
  final loginBtn = Container(
    margin: margin,
    padding: EdgeInsets.all(15.0),
    alignment: FractionalOffset.center,
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.all(const Radius.circular(100.0)),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0xFF696969),
          offset: Offset(1.0, 6.0),
          blurRadius: 0.001,
        ),
      ],
    ),
    child: FashionFetishText(
      text: buttonLabel,
      size: 20,
      color: Colors.white,
      fontWeight: FashionFontWeight.normal,
      height: 1.05,
    ),
  );
  return loginBtn;
}
