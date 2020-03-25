import 'package:flutter/material.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/widgets/buttons.dart';

class Welcome extends StatefulWidget {
  @override
  WelcomeState createState() => WelcomeState();
}

class WelcomeState extends State<Welcome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          children: <Widget>[
            Padding(
              child: Container(
                child: Center(
                  child: Text(
                      'Travel?',
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              padding: const EdgeInsets.only(top: 300),
            ),
            Padding(
              child: Container(
                child: filledButton("LORY", Colors.white, Colors.deepOrange, Theme.of(context).accentColor,
                    Colors.white, () {
                      Navigator.pushNamed(
                        context,
                        '/auth'
                      );
                    }),
                height: 50,
              ),
              padding: const EdgeInsets.only(top: 60, left: 120, right: 120),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.stretch,
        ));
  }
}