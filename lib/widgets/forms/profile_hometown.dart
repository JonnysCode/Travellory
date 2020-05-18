import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../font_widgets.dart';

class ProfileHometown extends StatefulWidget {
  const ProfileHometown({Key key, this.user}) : super(key: key);

  final user;

  @override
  _TextInputValueState createState() => _TextInputValueState();
}

class _TextInputValueState extends State<ProfileHometown> {
  TextEditingController _textEditingController = TextEditingController();
  bool showHometown = true;
  String newHometown = "";

  void _editHometown(){
    setState(() {
      newHometown = _textEditingController.text;
      showHometown = !showHometown;
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
              visible: showHometown,
              child: Row(
                key: Key('show_hometown'),
                children: [
                  FashionFetishText(
                    text: newHometown,
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
                    onPressed: _editHometown,
                  )
                ],
              ),
              replacement: Row(
                key: Key('edit_hometown'),
                children: [
                  SizedBox(
                    width: 200,
                    child: TextField(
                      controller: _textEditingController,
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
                        hintText: widget.user.hometown,
                        hintStyle: TextStyle(
                            fontSize: 18,
                            fontFamily: 'FashionFetish',
                            color: Colors.grey,
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
                    onPressed: _editHometown,
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