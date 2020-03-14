import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travellory/screens/authenticate/sign_in_register_option_sheet.dart';
import 'package:travellory/screens/authenticate/start_screen.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class SignInSheet{
  final _formKey = GlobalKey<FormState>();

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String _email;
  String _password;
  String _error = '';

  SignInSheet(GlobalKey<ScaffoldState> scaffoldKey){
    _scaffoldKey = scaffoldKey;
  }

  _signIn(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      LoadingState.makeLoading(true);

      final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      )).user;
      //dynamic result = await _auth.signInWithEmailAndPassword(_email, _password);
      if(user == null){
          _error = 'Could not sign in with those credentials.';
          print(_error);
          LoadingState.makeLoading(false);
      }
    }
  }

  signInSheet() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
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
                        left: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _emailController.clear();
                            _passwordController.clear();
                            SignInRegisterOption(_scaffoldKey).optionSheet();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
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
                  child: Column(
                    children: <Widget>[
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
                                    image: DecorationImage(
                                      image: AssetImage("assets/images/login/world.png"),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                child: Text(
                                  "LOGIN",
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(bottom: 10, top: 40),
                                child: inputAuthentication(Icon(Icons.email), "EMAIL", Theme.of(context).primaryColor,
                                    _emailController, ValidatorType.EMAIL, false),
                              ),
                              Padding(
                                padding: EdgeInsets.only(bottom: 20),
                                child: inputAuthentication(Icon(Icons.lock), "PASSWORD", Theme.of(context).primaryColor,
                                    _passwordController, ValidatorType.PASSWORD, true),
                              ),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 20,
                                    right: 20,
                                    bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Container(
                                  child: filledButton("LOGIN", Colors.white, Theme.of(context).primaryColor,
                                      Theme.of(context).primaryColor, Colors.white, () => _signIn(context)),
                                  height: 50,
                                  width: MediaQuery.of(context).size.width,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        _error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ],
            ),
            height: MediaQuery.of(context).size.height / 1.05,
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
      );
    });
  }
}

