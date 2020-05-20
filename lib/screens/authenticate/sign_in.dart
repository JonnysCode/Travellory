import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/shared/loading_logo.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/auth_background.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:pedantic/pedantic.dart';

class SignIn extends StatefulWidget {
  static const route = '/login';

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
      body: AuthBackground(
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
    );
  }
}
