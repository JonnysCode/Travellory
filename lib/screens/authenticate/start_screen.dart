import 'package:flutter/material.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:travellory/screens/authenticate/sign_in_register_option_sheet.dart';

class HomeTest extends StatefulWidget {
  @override
  _HomeTestState createState() => _HomeTestState();
}

class _HomeTestState extends State<HomeTest> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String _email;
  String _password;
  String _displayName;
  bool _obsecure = false;

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    void initState() {
      super.initState();
    }

    //login and register fuctions
    void _loginUser() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _emailController.clear();
      _passwordController.clear();
    }

    void _registerUser() {
      _email = _emailController.text;
      _password = _passwordController.text;
      _displayName = _nameController.text;
      _emailController.clear();
      _passwordController.clear();
      _nameController.clear();
    }

    void _registerSheet() {
      _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
        return DecoratedBox(
          decoration: BoxDecoration(color: Theme.of(context).canvasColor),
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
                          left: 10,
                          top: 10,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              _emailController.clear();
                              _passwordController.clear();
                              _nameController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              size: 30.0,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        )
                      ],
                    ),
                    height: 50,
                    width: 50,
                  ),
                  SingleChildScrollView(
                    child: Column(children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 140,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Align(
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 25, right: 40),
                                child: Text(
                                  "REGI",
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              child: Align(
                                child: Container(
                                  padding: EdgeInsets.only(top: 40, left: 28),
                                  width: 130,
                                  child: Text(
                                    "STER",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                          top: 60,
                        ),
                        child: inputAuthentication(Icon(Icons.account_circle),
                            "DISPLAY NAME", Theme.of(context).primaryColor, _nameController, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 20,
                        ),
                        child: inputAuthentication(Icon(Icons.email), "EMAIL", Theme.of(context).primaryColor,
                            _emailController, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: inputAuthentication(Icon(Icons.lock), "PASSWORD", Theme.of(context).primaryColor,
                            _passwordController, true),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          child: filledButton("REGISTER", Colors.white, primary,
                              primary, Colors.white, _registerUser),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ]),
                  ),
                ],
              ),
              height: MediaQuery.of(context).size.height / 1.1,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
            ),
          ),
        );
      });
    }

    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            Padding(
              child: Container(
                child: Center(
                  child: Text(
                      'TRAVEL?',
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              padding: const EdgeInsets.only(top: 300),
            ),
            Padding(
              child: Container(
                child: filledButton("YES", Colors.white, Colors.deepOrange, Theme.of(context).accentColor,
                    Colors.white, () => SignInRegisterOption(_scaffoldKey).optionSheet()),
                height: 50,
              ),
              padding: const EdgeInsets.only(top: 60, left: 120, right: 120),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}