import 'package:flutter/material.dart';
import 'package:travellory/screens/authenticate/sign_in_register_option_sheet.dart';
import 'package:travellory/utils/input_validator.dart';
import 'package:travellory/widgets/input_widgets.dart';
import 'package:travellory/widgets/buttons.dart';

class RegisterSheet {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  String _email;
  String _password;
  String _displayName;

  RegisterSheet(GlobalKey<ScaffoldState> scaffoldKey){
    _scaffoldKey = scaffoldKey;
  }


  registerSheet() {
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
                        left: 10,
                        top: 10,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            _emailController.clear();
                            _passwordController.clear();
                            _nameController.clear();
                            SignInRegisterOption(_scaffoldKey).optionSheet();
                          },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 30.0,
                            color: Theme.of(context).primaryColor,
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
                        height: 140,
                        child: Stack(
                          children: <Widget>[
                            Positioned(
                              child: Align(
                                child: Container(
                                  width: 130,
                                  height: 130,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Theme.of(context).primaryColor),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              child: Container(
                                padding: EdgeInsets.only(bottom: 25, right: 40),
                                child: Text(
                                  "REGI",
                                  style: TextStyle(
                                    fontSize: 44,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                alignment: Alignment.center,
                              ),
                            ),
                            Positioned(
                              child: Align(
                                child: Container(
                                  padding: EdgeInsets.only(top: 40, left: 28),
                                  width: 130,
                                  child: Text(
                                    "STER",
                                    style: TextStyle(
                                      fontSize: 40,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
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
                          bottom: 10,
                          top: 40,
                        ),
                        child: inputAuthentication(Icon(Icons.account_circle), "USERNAME", Theme.of(context).primaryColor,
                            _nameController, ValidatorType.USERNAME, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10,
                        ),
                        child: inputAuthentication(Icon(Icons.email), "EMAIL", Theme.of(context).primaryColor,
                            _emailController, ValidatorType.EMAIL, false),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: inputAuthentication(Icon(Icons.lock), "PASSWORD", Theme.of(context).primaryColor,
                            _passwordController, ValidatorType.PASSWORD, true),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: MediaQuery.of(context).viewInsets.bottom),
                        child: Container(
                          child: filledButton("REGISTER", Colors.white, Theme.of(context).primaryColor,
                              Theme.of(context).primaryColor, Colors.white, () => {}),
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

