import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/shared/constants.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  SignIn({ this.toggleView });

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String password = '';
  String error = '';

  Future _signIn(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
    if(result == null){
      setState(() => error = 'Could not sign in with those credentials.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        title: Text('Sign in to travellory'),
        actions: <Widget>[
          FlatButton.icon(
              onPressed: () {
                widget.toggleView();
              },
              icon: Icon(Icons.person),
              label: Text('Register')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                TextFormField(
                  key: Key('emailField'),
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => InputValidator.validate(val, ValidatorType.EMAIL),
                  onChanged: (val) => email = val,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  key: Key('passwordField'),
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => InputValidator.validate(val, ValidatorType.PASSWORD),
                  onChanged: (val) => password = val,
                ),
                SizedBox(height: 20.0),
                RaisedButton(
                    key: Key('signInButton'),
                    color: Theme.of(context).primaryColor,
                    child: Text(
                      'Sign in',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        setState(() => loading = true);
                        dynamic result = await _signIn(context);
                        if(result == null){
                          setState(() {
                            error = 'Could not sign in with those credentials.';
                            loading = false;
                          });
                        }
                      }
                    },
                ),
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontSize: 14.0),
                )
              ],
            ),
        ),
      ),
    );
  }
}
