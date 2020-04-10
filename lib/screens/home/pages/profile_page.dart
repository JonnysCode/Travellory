import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/utils/image_picker_handler.dart';
import 'package:travellory/widgets/font_widgets.dart';

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
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    imagePicker = ImagePickerHandler(this, _controller);
    imagePicker.init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                  boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))],
                ),
                child: Column(
                  key: Key('profile_page'),
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      key: Key('image_pick'),
                      onTap: () => imagePicker.showDialog(context),
                      child: Center(
                        child: _image == null
                            ? Stack(
                          children: <Widget>[
                            Center(
                              child: CircleAvatar(
                                radius: 130.0,
                                backgroundColor: Colors.blueGrey.withOpacity(0.5),
                              ),
                            ),
                            SizedBox(
                              height: 260,
                              child: Center(
                                child: Image.asset(
                                  'assets/photo_camera.png',
                                  height: 100,
                                  width: 100,
                                ),
                              ),
                            ),
                          ],
                        )
                            : Container(
                          height: 260.0,
                          width: 260.0,
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            image: DecorationImage(
                              image: ExactAssetImage(_image.path),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                                color: Theme.of(context).primaryColor, width: 2.0),
                            borderRadius:
                            BorderRadius.all(const Radius.circular(300.0)),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    FutureBuilder(
                        future: AuthProvider.of(context).auth.getCurrentUser(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return UserInformation(user: snapshot.data);
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    SizedBox(height: 100),
                    FlatButton.icon(
                      onPressed: () => _signOut(),
                      icon: Icon(Icons.exit_to_app),
                      label: FashionFetishText(
                        text: 'Log out',
                        size: 20,
                        fontWeight: FashionFontWeight.normal,
                        height: 1.05,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 15,
            left: 25,
            child: Image(
              image: AssetImage('assets/images/logo/travellory_icon.png'),
              height: 80,
            ),
          )
        ],
      ),
    );
  }

  @override
  void userImage(File _image) {
    setState(() {
      this._image = _image;
    });
  }

  Future _signOut() async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
    await Navigator.pushReplacementNamed(context, '/');
  }
}

class UserInformation extends StatefulWidget {
  const UserInformation({
    Key key,
    this.user,
  }) : super(key: key);

  final FirebaseUser user;

  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  @override
  Widget build(BuildContext context) {
    final user = widget.user;

    return Column(key: Key('display_user'), children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
          SizedBox(width: 10),
          FashionFetishText(
            text: user != null ? '${user.displayName}' : '',
            size: 18,
            fontWeight: FashionFontWeight.normal,
            height: 1.05,
          ),
        ]
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Icon(
            Icons.email,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
          SizedBox(width: 10),
          FashionFetishText(
            text: user != null ? '${user.email}' : '',
            size: 18,
            fontWeight: FashionFontWeight.normal,
            height: 1.05,
          ),
        ]
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(width: 20),
          Icon(
            Icons.date_range,
            color: Theme.of(context).primaryColor,
            size: 40,
          ),
          SizedBox(width: 10),
          FashionFetishText(
            text: user != null
                ? '${DateFormat('dd.MM.yyyy').format(user.metadata.creationTime)}'
                : '',
            size: 18,
            fontWeight: FashionFontWeight.normal,
            height: 1.05,
          ),
        ]
      ),
    ]);
  }
}
