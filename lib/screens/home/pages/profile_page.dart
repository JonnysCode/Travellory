import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/utils/image_picker_handler.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin, ImagePickerListener {
  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = new ImagePickerHandler(this, _controller);
    imagePicker.init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('profile_page'),
      body: new GestureDetector(
        onTap: () => imagePicker.showDialog(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Center(
              child: _image == null
                  ? new Stack(
                children: <Widget>[
                  new Center(
                    child: new CircleAvatar(
                      radius: 130.0,
                      backgroundColor: Theme
                          .of(context)
                          .primaryColor,
                    ),
                  ),
                  new SizedBox(
                    height: 260,
                    child: Center(
                      child: new Image.asset(
                        "assets/photo_camera.png",
                        height: 100,
                        width: 100,
                      ),
                    ),
                  ),
                ],
              )
                  : new Container(
                height: 260.0,
                width: 260.0,
                decoration: new BoxDecoration(
                  color: Theme
                      .of(context)
                      .primaryColor,
                  image: new DecorationImage(
                    image: new ExactAssetImage(_image.path),
                    fit: BoxFit.cover,
                  ),
                  border: Border.all(
                      color: Theme
                          .of(context)
                          .primaryColor, width: 2.0),
                  borderRadius:
                  new BorderRadius.all(const Radius.circular(300.0)),
                ),
              ),
            ),
            SizedBox(height: 50),
            FutureBuilder(
                future: AuthProvider
                    .of(context)
                    .auth
                    .getCurrentUser(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return displayUserInformation(context, snapshot);
                  } else {
                    return CircularProgressIndicator();
                  }
                }),
            SizedBox(height: 100),
            FlatButton.icon(
              onPressed: () => _signOut(),
              icon: Icon(Icons.exit_to_app),
              label: FashionFetishText(
                text: "Log out",
                size: 20,
                fontWeight: FashionFontWeight.NORMAL,
                height: 1.05,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

  Future _signOut() async {
    final BaseAuthService _auth = AuthProvider
        .of(context)
        .auth;
    await _auth.signOut();
    Navigator.pushReplacementNamed(context, '/');
  }

  Widget displayUserInformation(context, snapshot) {
    final user = snapshot.data;
    return Column(key: Key('display_user'), children: [
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 50),
        Icon(
          Icons.person,
          color: Theme
              .of(context)
              .primaryColor,
          size: 40,
        ),
        SizedBox(width: 20),
        FashionFetishText(
          text: "${user.displayName}",
          size: 20,
          fontWeight: FashionFontWeight.NORMAL,
          height: 1.05,
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 50),
        Icon(
          Icons.email,
          color: Theme
              .of(context)
              .primaryColor,
          size: 40,
        ),
        SizedBox(width: 20),
        FashionFetishText(
          text: "${user.email}",
          size: 20,
          fontWeight: FashionFontWeight.NORMAL,
          height: 1.05,
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 50),
        Icon(
          Icons.date_range,
          color: Theme
              .of(context)
              .primaryColor,
          size: 40,
        ),
        SizedBox(width: 20),
        FashionFetishText(
          text: "${DateFormat('dd.MM.yyyy').format(
              user.metadata.creationTime)}",
          size: 20,
          fontWeight: FashionFontWeight.NORMAL,
          height: 1.05,
        ),
      ]),
    ]);
  }
}
