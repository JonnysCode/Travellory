import 'package:flutter/material.dart';
import 'package:travellory/screens/authenticate/register_sheet.dart';
import 'package:travellory/screens/authenticate/sign_in_sheet.dart';
import 'package:travellory/widgets/buttons.dart';

class SignInRegisterOption {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  SignInRegisterOption(GlobalKey<ScaffoldState> scaffoldKey){
    _scaffoldKey = scaffoldKey;
  }

  optionSheet() {
    _scaffoldKey.currentState.showBottomSheet<void>((BuildContext context) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0)),
          child: Container(
            child: ListView(
              children: <Widget>[
                Container(
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
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.clear,
                            size: 26.0,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  height: 50,
                  width: 50,
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
                                alignment: Alignment.center,
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
                          child: filledButton("LOGIN", Colors.white, Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor, Colors.white, () => SignInSheet(_scaffoldKey).signInSheet()),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
                          child: filledButton("REGISTER", Colors.white, Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor, Colors.white, () => RegisterSheet(_scaffoldKey).registerSheet()),
                          height: 50,
                          width: MediaQuery.of(context).size.width,
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
            height: MediaQuery.of(context).size.height / 1.05,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login/beach.png"),
                fit: BoxFit.fitWidth,
                alignment: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
      );
    });
  }
}