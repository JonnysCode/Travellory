import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../font_widgets.dart';

class ProfileHometown extends StatefulWidget {
  _TextInputValueState createState() => _TextInputValueState();
}

class _TextInputValueState extends State<ProfileHometown> {
  String _hometown = "Switzerland";
  bool visible = false;

  void _setVisibility(){
    setState(() {
      visible = !visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
      Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.home,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
            SizedBox(width: 10),
            Visibility(
              visible: visible,
              child: Row(
                children: <Widget>[
                  FashionFetishText(
                    text: "$_hometown",
                    size: 18,
                    fontWeight: FashionFontWeight.bold,
                    height: 1.1,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.grey,
                        size: 20
                    ),
                    onPressed: _setVisibility,
                  )
                ],
              ),
              replacement: Row(
                children: <Widget>[
                  SizedBox(
                    width: 200,
                      child: TextField(
                        autofocus: true,
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'FashionFetish',
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.0,
                          height: 1.1
                        ),
                        decoration: InputDecoration(
                          hintText: "$_hometown",
                          hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'FashionFetish',
                            color: Colors.grey
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                        FontAwesomeIcons.save,
                        color: Theme.of(context).primaryColor,
                        size: 20
                    ),
                    onPressed: _setVisibility,
                  )
                ],
              ),
            )
          ]
      ),
      ]
    );
  }
}