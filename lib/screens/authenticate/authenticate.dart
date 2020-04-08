import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/buttons.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Container(
              child: DecoratedBox(
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
                                left: 10,
                                top: 9,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  icon: Icon(
                                    FontAwesomeIcons.times,
                                    size: 24.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SingleChildScrollView(
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
                                        Navigator.pushNamed(context, '/login');
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
                                        Navigator.pushNamed(context, '/register');
                                      }),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ),
        ],
      ),
    );
  }
}
