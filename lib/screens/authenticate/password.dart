import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:flushbar/flushbar.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({this.toggleView});
  final Function toggleView;

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final String alertText = "You've successfully changed your password.";

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _reauthError;
  String _changePwError;

  Future _validateAndChangePW() async {
    if (_formKey.currentState.validate()) {
      Navigator.pushNamed(context, '/loading');

      await _changePassword().then((value) async {
        setState(() => _changePwError = null);
        Navigator.popUntil(context, ModalRoute.withName('/'));
        _showSnackBar();
      }).catchError((error) {
        setState(
                () => _changePwError = 'Password could not be changed. Try again.');
        Navigator.pop(context);
      });
    }
  }

  Future _changePassword() async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.reauthenticate(_oldPasswordController.text).then((result) {
      setState(() => _reauthError = null);
      return _auth.changePassword(_passwordController.text);
    }).catchError((error) {
      setState(() => _reauthError = 'Please supply a valid password.');
      return Future.error(error);
    });
  }

  Widget _showSnackBar() {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: "Success",
          message: alertText,
          backgroundColor: Theme.of(context).primaryColor,
          margin: EdgeInsets.all(8),
          borderRadius: 12,
          duration: Duration(seconds: 3)
      )..show(context),
    );
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
              height: MediaQuery.of(context).size.height * 0.05
          ),
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/login/beach.png"),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter
                  ),
                ),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: 50,
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
                                  color: Theme.of(context).primaryColor
                              ),
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
                                  color: Colors.white
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(top: 20, bottom: 8),
                            child: Text(
                              'Please first enter the old password',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontSize: 16
                              ),
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: inputAuthentication(
                                      Icon(FontAwesomeIcons.unlockAlt),
                                      "OLD PASSWORD",
                                      Theme.of(context).primaryColor,
                                      _oldPasswordController,
                                      null,
                                      ValidatorType.password,
                                      true,
                                      _reauthError
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: inputAuthentication(
                                      Icon(FontAwesomeIcons.unlockAlt),
                                      "NEW PASSWORD",
                                      Theme.of(context).primaryColor,
                                      _passwordController,
                                      null,
                                      ValidatorType.password,
                                      true,
                                      _changePwError
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets.bottom
                                  ),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width,
                                    child: filledButton(
                                        "SAVE",
                                        Colors.white,
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).primaryColor,
                                        Colors.white,
                                        _validateAndChangePW
                                    ),
                                  ),
                                ),
                              ],
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
