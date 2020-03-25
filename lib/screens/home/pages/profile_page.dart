import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
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
          )
        ],
      ),
    );
  }
}

