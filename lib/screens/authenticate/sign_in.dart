import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/shared/loading_logo.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:pedantic/pedantic.dart';

class SignIn extends StatefulWidget {
  static final route = '/login';

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _error = '';

  Future _validateSignIn() async {
    if (_formKey.currentState.validate()) {
      unawaited(Navigator.pushNamed(context, LoadingLogo.route));
      await _signIn().then((_) {
        Navigator.popUntil(
          context,
          ModalRoute.withName('/'),
        );
      }).catchError((e) {
        Navigator.pop(context);
        setState(() {
          _error =
              e.message ?? 'Something went wrong. Try again';
        });
      });
    }
  }

  Future _signIn() async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    final user = await _auth
        .signInWithEmailAndPassword(
            _emailController.text, _passwordController.text)
        .catchError((e) {
      return Future.error(e);
    });

    return user;
  }

  @override
  void dispose() {
    _emailController.dispose();
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
          DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0)),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.95,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/login/beach.png"),
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.bottomCenter,
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
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          Positioned(
                            left: 8,
                            top: 8,
                            child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                _emailController.clear();
                                _passwordController.clear();
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
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 140,
                            child: Stack(
                              children: <Widget>[
                                Positioned(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      width: 130,
                                      height: 130,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        fontSize: 48,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFFF7EDEE),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding:
                                      EdgeInsets.only(bottom: 10, top: 40),
                                  child: inputAuthentication(
                                      Icon(Icons.email),
                                      "EMAIL",
                                      Theme.of(context).primaryColor,
                                      _emailController,
                                      null,
                                      ValidatorType.email,
                                      false,
                                      null),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 20),
                                  child: inputAuthentication(
                                      Icon(Icons.lock),
                                      "PASSWORD",
                                      Theme.of(context).primaryColor,
                                      _passwordController,
                                      null,
                                      ValidatorType.password,
                                      true,
                                      null),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  child: Container(
                                    height: 50,
                                    width:
                                        MediaQuery.of(context).size.width,
                                    child: filledButton(
                                        "LOGIN",
                                        Colors.white,
                                        Theme.of(context).primaryColor,
                                        Theme.of(context).primaryColor,
                                        Colors.white,
                                        _validateSignIn),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            _error,
                            style:
                                TextStyle(color: Colors.red, fontSize: 14.0),
                          )
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
