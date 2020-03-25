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
  }

//  void _changePassword(String password) async{
//    FirebaseUser user = await FirebaseAuth.instance.currentUser();
//
//    user.updatePassword(password).then((_){
//      print("Succesfull changed password");
//    }).catchError((error){
//      print("Password can't be changed" + error.toString());
//      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
//    });
//  }

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
            onPressed: () => {},
            child: const Text(
                'change password',
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Arial',
            )
            ),
          ),
          RaisedButton( //TODO: fluetfab remove if logout above profile view works
            onPressed: () {},
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

