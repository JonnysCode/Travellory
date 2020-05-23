import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/authentication/user_management.dart';
import 'package:pedantic/pedantic.dart';

class ProfileHomeCountry extends StatefulWidget {
  const ProfileHomeCountry({Key key, this.user}) : super(key: key);

  final UserModel user;

  @override
  _TextInputValueState createState() => _TextInputValueState();
}

class _TextInputValueState extends State<ProfileHomeCountry> {
  Country _selectedDialogCountry =
    CountryPickerUtils.getCountryByName('Switzerland');

  bool showHomeCountry = true;
  String currentHomeCountry = 'loading...';
  String newHomeCountry = '';

  void _editHomeCountry(){
    setState(() {
      newHomeCountry = _selectedDialogCountry.name.toString();
      showHomeCountry = !showHomeCountry;
    });

    UserManagement.setHomeCountry(widget.user.uid, newHomeCountry)
    .catchError((error) {
      _showSnackBar('Setting home country failed', false);
    });
  }

  Future _fetchHomeCountry() async {
    await UserManagement.getHomeCountry(widget.user.uid)
        .then((homeCountry) {
      if(mounted) {
        setState(() {
          currentHomeCountry = homeCountry;
        });
      }
    }).catchError((error) {
      _showSnackBar('Fetching home country failed', false);
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
    unawaited(_fetchHomeCountry());
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
              visible: showHomeCountry,
              replacement: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                key: Key('edit_homeCountry'),
                children: [
                  Container(
                      padding: EdgeInsets.all(0),
                      constraints: BoxConstraints(minWidth: 20, maxWidth: 200),
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
                    onPressed: _editHomeCountry,
                  )
                ],
              ),
              child: Expanded(
                child: Row(
                  key: Key('show_homeCountry'),
                  children: [
                    Flexible(
                      child: Text(
                        currentHomeCountry,
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
                      onPressed: _editHomeCountry,
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