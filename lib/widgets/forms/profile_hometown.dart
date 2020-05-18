import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../font_widgets.dart';

class ProfileHometown extends StatefulWidget {
  _TextInputValueState createState() => _TextInputValueState();
}

class _TextInputValueState extends State<ProfileHometown> {
  TextEditingController _textInputController = TextEditingController();
  String _showText = "";

  _onPressed() {
    setState(() {
      _showText = _textInputController.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool visible = false;

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
                    text: "$_showText",
                    size: 18,
                    fontWeight: FashionFontWeight.bold,
                    height: 1.1,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                        FontAwesomeIcons.pen,
                        color: Colors.red,
                        size: 20
                    ),
                    onPressed: null,
                  )
                ],
              ),
              replacement: Row(
                children: <Widget>[
                  FashionFetishText(
                    text: "$_showText",
                    size: 18,
                    fontWeight: FashionFontWeight.bold,
                    height: 1.1,
                  ),
                  SizedBox(width: 10),
                  IconButton(
                    icon: Icon(
                        FontAwesomeIcons.save,
                        color: Theme.of(context).primaryColor,
                        size: 20
                    ),
                    onPressed: null,
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