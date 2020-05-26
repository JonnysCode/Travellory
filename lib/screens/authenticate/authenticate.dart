import 'package:flutter/material.dart';
import 'package:travellory/screens/authenticate/register.dart';
import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/widgets/auth_background.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

class Authenticate extends StatelessWidget {
  static const route = '/auth';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthBackground(
        hasExitButton: true,
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/images/logo/logo_splash.png"),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 60,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: filledButton("LOGIN", Colors.white, Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor, Colors.white, () {
                      Navigator.pushNamed(context, SignIn.route);
                    }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: filledButton("REGISTER", Colors.white, Theme.of(context).primaryColor,
                    Theme.of(context).primaryColor, Colors.white, () {
                      Navigator.pushNamed(context, Register.route);
                    }),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      )
    );
  }
}
