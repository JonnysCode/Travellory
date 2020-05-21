import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/authentication/user_management.dart';
import '../font_widgets.dart';
import 'package:pedantic/pedantic.dart';

class ProfileHometown extends StatefulWidget {
  const ProfileHometown({Key key, this.user}) : super(key: key);

  final UserModel user;

  @override
  _TextInputValueState createState() => _TextInputValueState();
}

class _TextInputValueState extends State<ProfileHometown> {
  TextEditingController _textEditingController = TextEditingController();
  bool showHometown = true;
  String currentHometown = 'loading...';
  String newHometown = '';

  void _editHometown(){
    setState(() {
      newHometown = _textEditingController.text;
      showHometown = !showHometown;
    });

    UserManagement.setHometown(widget.user.uid, newHometown)
    .catchError((error) {
      _showSnackBar('Setting hometown failed', false);
    });
  }

  Future _getHometown() async {
    await UserManagement.getHometown(widget.user.uid)
        .then((hometown) {
      if(mounted) {
        setState(() {
          currentHometown = hometown;
        });
      }
    }).catchError((error) {
      _showSnackBar('Fetching hometown failed', false);
    });
  }

  Widget _showSnackBar(String messageToDisplay, bool isSuccessful) {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: isSuccessful ? 'Success' : 'Error',
          message: messageToDisplay,
          backgroundColor:
          isSuccessful ? Theme.of(context).primaryColor : Colors.redAccent,
          margin: EdgeInsets.all(8),
          borderRadius: 12,
          duration: Duration(seconds: 3))
        ..show(context),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    unawaited(_getHometown());
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
                    text: currentHometown,
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
                        hintText: currentHometown,
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