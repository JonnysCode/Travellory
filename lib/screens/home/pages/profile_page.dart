import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/widgets/buttons.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider
        .of(context)
        .auth;
    await _auth.signOut();
    await Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('profile_page'),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: 60,
                left: 90,
                right: 90,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: filledButton("Change password", Colors.white, Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor, Colors.white, () {
                    Navigator.pushNamed(context, '/password');
                  }),
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 90,
                right: 90,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: filledButton("Friends", Colors.white, Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor, Colors.white, () {
                    Navigator.pushNamed(context, '/friends/friends_page');
                  }),
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.only(
                left: 90,
                right: 90,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              child: filledButton("Logout", Colors.white, Theme.of(context).primaryColor,
                  Theme.of(context).primaryColor, Colors.white, () async {
                    _signOut(context);
                  }),
              height: 40,
              width: MediaQuery.of(context).size.width,
            ),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
