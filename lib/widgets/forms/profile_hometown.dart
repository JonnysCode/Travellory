import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
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
  Country _selectedDialogCountry =
    CountryPickerUtils.getCountryByName('Switzerland');

  final TextEditingController _textEditingController = TextEditingController();
  bool showHometown = true;
  String currentHometown = 'loading...';
  String newHometown = '';

  void _editHometown(){
    setState(() {
      newHometown = _textEditingController.text;
//      newHometown = _selectedDialogCountry as String;
      showHometown = !showHometown;
    });

    UserManagement.setHometown(widget.user.uid, newHometown)
    .catchError((error) {
      _showSnackBar('Setting hometown failed', false);
    });
  }

  Future _fetchHometown() async {
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

  Widget _showSnackBar(String message, bool success) {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: success ? 'Success' : 'Error',
          message: message,
          backgroundColor:
          success ? Theme.of(context).primaryColor : Colors.redAccent,
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
    unawaited(_fetchHometown());
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
              replacement: Row(
                key: Key('edit_hometown'),
                children: [
                  Container(
                    constraints: BoxConstraints(minWidth: 20, maxWidth: 250) ,
                    child: ListTile(
                      onTap: _openCountryPickerDialog,
                      title: _buildDialogItem(_selectedDialogCountry),
                    ),
//                    child: TextField(
//                      controller: _textEditingController,
//                      autofocus: true,
//                      style: TextStyle(
//                          fontSize: 18,
//                          fontFamily: 'FashionFetish',
//                          color: Colors.black,
//                          fontWeight: FontWeight.w600,
//                          letterSpacing: -1.0,
//                          height: 1.1
//                      ),
//                      decoration: InputDecoration(
//                        hintText: currentHometown,
//                        hintStyle: TextStyle(
//                          fontSize: 18,
//                          fontFamily: 'FashionFetish',
//                          color: Colors.grey,
//                        ),
//                        border: InputBorder.none,
//                      ),
//                    ),
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
            )
          ]
        ),
      ]
    );
  }

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
//      SizedBox(width: 8.0),
      Flexible(
        child: Container(
          padding: EdgeInsets.only(
            bottom: 3
          ),
          child:Text(
            country.name,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'FashionFetish',
              fontWeight: FontWeight.w600,
              letterSpacing: -1.0
            )
          ),
        ),
      )
    ],
  );

  void _openCountryPickerDialog() => showDialog(
    context: context,
    builder: (context) => Theme(
      data: Theme.of(context).copyWith(primaryColor: Colors.black),
      child: CountryPickerDialog(
        searchCursorColor: Theme.of(context).primaryColor,
        searchInputDecoration: InputDecoration(
          hintStyle: TextStyle(
            fontFamily: 'FashionFetish',
            fontSize: 14,
            color: Colors.grey
          ),
          hintText: 'Search...'),
        isSearchable: true,
        title: Text('Select your country'),
        onValuePicked: (Country country) =>
            setState(() => _selectedDialogCountry = country),
        itemBuilder: _buildDialogItem,
      ),
    ),
  );
}