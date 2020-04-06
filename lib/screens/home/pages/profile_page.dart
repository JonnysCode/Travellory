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
    await Navigator.pushReplacementNamed(context, '/');
  }

//  Future _changePassword(BuildContext context) async {
//    //final BaseAuthService _auth = AuthProvider.of(context).auth;
//    //await _auth.signOut();
//    await Navigator.pushReplacementNamed(context, '/profile_page_password.dart');
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
            onPressed: () {
              Navigator.of(context).push<void>(_createRoute());
            }, //TODO: link new site profile_page_password
            child: const Text(
                'change password',
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

Route _createRoute() {
  return PageRouteBuilder<SlideTransition>(
    pageBuilder: (context, animation, secondaryAnimation) => _Page2(),
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

class _Page2 extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black,fontSize: 20.0),
              border: UnderlineInputBorder(),
              hintText: '*********',
              hintStyle: TextStyle(color: Colors.black),
              labelText: "Old password",
            ),
          ),
          TextFormField(
            decoration: InputDecoration(
              labelStyle: TextStyle(color: Colors.black,fontSize: 20.0),
              border: UnderlineInputBorder(),
              hintText: '*********',
              hintStyle: TextStyle(color: Colors.black),
              labelText: "New password"
            ),
          ),
          RaisedButton(
            onPressed: () => null,
            child: const Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Arial',
                )
            ),
          ),
        ],
      ),
    );
  }
}

