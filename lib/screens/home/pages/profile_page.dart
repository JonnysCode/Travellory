import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/widgets/font_widgets.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
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
          SizedBox(
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
            onPressed: () {},
            child: const Text(
                'change password',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
            )
            ),
          ),
          RaisedButton(
            onPressed: () {},
            child: const Text(
                'change profile picture',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
                )
            ),
          )
        ],
      ),
    );
  }
}

