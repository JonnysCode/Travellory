import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/authentication/user_management.dart';
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

  bool showHometown = true;
  String currentHometown = 'loading...';
  String newHometown = '';

  void _editHometown(){
    setState(() {
      newHometown = _selectedDialogCountry.name.toString();
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
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key('edit_hometown'),
                children: [
                  Container(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(minWidth: 20, maxWidth: 250),
                      height: 40,
                      child: ListTile(
                        contentPadding: EdgeInsets.only(left: 0),
                        onTap: _openCountryPickerDialog,
                        title: _buildDialogItem(_selectedDialogCountry),
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
              child: Expanded(
                child: Row(
                  key: Key('show_hometown'),
                  children: [
                    Flexible(
                      child: Text(
                        currentHometown,
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontFamily: 'FashionFetish',
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            height: 1.1,
                            letterSpacing: -1
                        ),
                      ),
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
              ),
            )
          ]
        ),
      ]
    );
  }

  Widget _buildDialogItem(Country country) => Row(
    children: <Widget>[
      Flexible(
        child: Container(
          padding: EdgeInsets.all(0),
          child:Text(
            country.name,
            overflow: TextOverflow.fade,
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'FashionFetish',
              fontStyle: FontStyle.italic,
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
        title: Text(
          'Select your country',
          style: TextStyle(
            fontFamily: 'FashionFetish',
            fontSize: 22,
            fontWeight: FontWeight.w600,
            letterSpacing: -2
          ),
        ),
        onValuePicked: (Country country) =>
            setState(() => _selectedDialogCountry = country),
        itemBuilder: _buildDialogItem,
      ),
    ),
  );
}