import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';

class Register extends StatefulWidget {

  final Function toggleView;
  Register({ this.toggleView });

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String _error = '';

  Future _register(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    dynamic result = await _auth.registerWithEmailAndPassword(_emailController.text, _passwordController.text);
    if(result == null){
      setState(() => _error = 'Please supply a valid email and password.');
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
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
                            Container(
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 10,
                                        top: 40,
                                      ),
                                      child: inputAuthentication(Icon(Icons.account_circle), "USERNAME", Theme.of(context).primaryColor,
                                          _nameController, ValidatorType.USERNAME, false),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        bottom: 10,
                                      ),
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
                                        child: filledButton("REGISTER", Colors.white, Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColor, Colors.white, () async {
                                              if (_formKey.currentState.validate()) {
                                                Navigator.pushNamed(context, '/loading');
                                                dynamic result = await _register(context);
                                                if (result == null) {
                                                  setState(() {
                                                    _error = 'Please supply a valid email and password.';
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
