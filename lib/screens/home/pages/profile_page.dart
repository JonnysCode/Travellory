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
          filledButton("change password", Colors.white, Theme
              .of(context)
              .primaryColor,
              Theme
                  .of(context)
                  .primaryColor, Colors.white, () async {
                Navigator.pushNamed(context, '/password');
              }
          ),
          //TODO: fluetfab add filled button for friends
          filledButton("friends", Colors.white, Theme
              .of(context)
              .primaryColor,
              Theme
                  .of(context)
                  .primaryColor, Colors.white, () async {
                Navigator.pushNamed(context, '/friends');
              }
          ),
          //TODO: fluetfab add filled button for logout

        ],
      ),
    );
  }
}
