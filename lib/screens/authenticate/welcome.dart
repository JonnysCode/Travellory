import 'package:flutter/material.dart';
import 'package:travellory/services/navigation_service.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

import '../../service_locator.dart';

class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        key: _scaffoldKey,
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
                      locator<NavigationService>().navigateTo('auth');
//                      Navigator.pushNamed(
//                        context,
//                        '/auth'
//                      );
                    }),
              ),
            ),
          ],
        )
    );
  }
}