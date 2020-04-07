import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';

class ChangePassword extends StatefulWidget {

  final Function toggleView;
  ChangePassword({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String alertText =
      "You've successfully changed your password.";

  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _error = '';

  Future _changePassword(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    dynamic authResult = await _auth.reauthenticate(_oldPasswordController.text);
    if(authResult != null){
      dynamic result = await _auth.changePassword(_passwordController.text);
      if(result == null){
        setState(() => _error = 'Please supply a valid password.');
      }
    }
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Theme.of(context).canvasColor,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0)),
                child: Container(
                  child: ListView(
                    children: <Widget>[
                      Container(
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              left: 18,
                              top: 18,
                              child: Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).primaryColor),
                              ),
                            ),
                            Positioned(
                              left: 8,
                              top: 8,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                  _passwordController.clear();
                                  _oldPasswordController.clear();
                                },
                                icon: Icon(
                                  FontAwesomeIcons.angleLeft,
                                  size: 30.0,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        ),
                        height: 50,
                        width: 50,
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 8),
                                child: Text(
                                  'Please first enter the old password',
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 16,

                                  ),
                                ),
                              )

                            ),

                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: inputAuthentication(Icon(FontAwesomeIcons.unlockAlt), "OLD PASSWORD", Theme.of(context).primaryColor,
                                          _oldPasswordController, ValidatorType.PASSWORD, true),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: inputAuthentication(Icon(FontAwesomeIcons.unlockAlt), "NEW PASSWORD", Theme.of(context).primaryColor,
                                          _passwordController, ValidatorType.PASSWORD, true),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Container(
                                        child: filledButton("SAVE", Colors.white, Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColor, Colors.white, () async {
                                              if (_formKey.currentState.validate()) {
                                                Navigator.pushNamed(context, '/loading');
                                                //TODO: fluetfab call first reauth pass the old password
                                                dynamic result = await _changePassword(context);
                                                if (result == null) {
                                                  setState(() {
                                                    _error = 'Please supply a valid password.';
                                                  });
                                                  Navigator.popUntil(
                                                    context,
                                                    ModalRoute.withName('/'),
                                                  );
                                                }
                                              }
                                            }),
                                        height: 50,
                                        width: MediaQuery.of(context).size.width,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.95,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/login/beach.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
