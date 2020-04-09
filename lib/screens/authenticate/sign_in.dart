import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String _error = '';

  Future _signIn(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    dynamic result = await _auth.signInWithEmailAndPassword(_emailController.text, _passwordController.text);
    if(result == null){
      setState(() => _error = 'Could not sign in with those credentials.');
    }
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
          Container(
            child:  DecoratedBox(
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
                                          color: Theme.of(context).primaryColor,
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
                                          color: Color(0xFFF7EDEE),
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
                                      child: inputAuthentication(Icon(FontAwesomeIcons.solidEnvelope), "EMAIL", Theme.of(context).primaryColor,
                                          _emailController, ValidatorType.EMAIL, false, null),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(bottom: 20),
                                      child: inputAuthentication(Icon(FontAwesomeIcons.unlockAlt), "PASSWORD", Theme.of(context).primaryColor,
                                          _passwordController, ValidatorType.PASSWORD, true, null),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          right: 20,
                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                      child: Container(
                                        child: filledButton("LOGIN", Colors.white, Theme.of(context).primaryColor,
                                            Theme.of(context).primaryColor, Colors.white, () async {
                                              if (_formKey.currentState.validate()) {
                                                Navigator.pushNamed(context, '/loading');
                                                dynamic result = await _signIn(context);
                                                if(result == null){
                                                  setState(() {
                                                    _error = 'Could not sign in with those credentials.';
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

/**
 * This is a test function call of a firebase cloud function. It will print the
 * result to the console
 * TODO: remove
 */
void _testFunCall() async {
  HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'payment-makePayment');

  try {
    final HttpsCallableResult result = await callable.call();
    print(result.data);

  } on CloudFunctionsException catch (e) {
    print('caught firebase functions exception');
    print(e.code);
    print(e.message);
    print(e.details);
  } catch (e) {
    print('caught generic exception');
    print(e);
  }
}
