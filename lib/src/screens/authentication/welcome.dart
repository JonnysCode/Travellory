import 'package:flutter/material.dart';
import 'package:travellory/src/screens/authentication/authenticate.dart';
import 'package:travellory/src/components/buttons/buttons.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Theme.of(context).primaryColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 300),
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
            Padding(
              padding: const EdgeInsets.only(top: 60, left: 120, right: 120),
              child: Container(
                height: 50,
                child: filledButton('easy', Colors.white, Colors.deepOrange, Theme.of(context).accentColor,
                    Colors.white, () {
                      Navigator.pushNamed(
                        context,
                        Authenticate.route
                      );
                    }),
              ),
            ),
          ],
        )
    );
  }
}