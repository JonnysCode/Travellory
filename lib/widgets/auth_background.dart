import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AuthBackground extends StatelessWidget {
  const AuthBackground({Key key, this.child, this.hasExitButton = false}):super(key: key);

  final Widget child;
  final bool hasExitButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: Theme.of(context).canvasColor,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.0),
                topRight: Radius.circular(40.0)),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.95,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/login/beach.png"),
                  fit: BoxFit.fitWidth,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: 50,
                    width: 50,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          left: 18,
                          top: 18,
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Theme.of(context).primaryColor),
                          ),
                        ),
                        Positioned(
                          left: hasExitButton ? 10.0 : 9.0,
                          top: 9.0,
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              hasExitButton ? FontAwesomeIcons.times : FontAwesomeIcons.angleLeft,
                              size: hasExitButton ? 26.0 : 29.0,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SingleChildScrollView(
                    child: child,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
