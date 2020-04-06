import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/utils/input_validator.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController _passwordController = TextEditingController();

  String _error = '';

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
    await Navigator.pushReplacementNamed(context, '/');
  }

  Future _updatePassword(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    dynamic result = await _auth.updatePassword(_passwordController.text);
    if(result == null){
      setState(() => _error = 'Please supply a valid password.');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('profile_page'),
      child: Column(
        children: <Widget>[
          FlatButton.icon(
            onPressed: () => _signOut(context),
            icon: Icon(Icons.person),
            label: Text('logout'),
          ),
          SizedBox( //TODO: fluetfab remove if profile view is available
            height: 350,
            width: 250,
            child: const Card(
              color: Colors.white60,
              child: Text(
                  'ProfileView\n',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Arial',
                  )
              ),
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push<void>(_createRoutePassword());
            },
            child: const Text(
                'Change password',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                )
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.of(context).push<void>(_createRouteFriends());
            },
            child: const Text(
                'Friends',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                )
            ),
          ),
          RaisedButton( //TODO: fluetfab remove if logout above profile view works
            onPressed: () => _signOut(context),
            child: const Text(
                'Logout',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                )
            ),
          ),
        ],
      ),
    );
  }
}

Route _createRoutePassword() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _UpdatePassword(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

Route _createRouteFriends() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _ShowFriends(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var tween = Tween<Offset>(begin: Offset(0.0, 1.0), end: Offset.zero);
      var curveTween = CurveTween(curve: Curves.ease);

      return SlideTransition(
        position: animation.drive(curveTween).drive(tween),
        child: child,
      );
    },
  );
}

class _UpdatePassword extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
              top: 40,
            ),
            child: inputAuthentication(Icon(FontAwesomeIcons.unlockAlt), "PASSWORD", Theme.of(context).primaryColor,
                _passwordController, ValidatorType.PASSWORD, true)),
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
                      dynamic result = await _updatePassword(context);
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
    );
  }
}

class _ShowFriends extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Text(
            'friendslist',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}


