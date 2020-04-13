import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/widgets/buttons.dart';
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
    return Column(
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
                          backgroundColor: Theme.of(context).primaryColor,
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
        SizedBox(height: 20),
        FutureBuilder(
            future: AuthProvider.of(context).auth.getCurrentUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return UserInformation(user: snapshot.data);
              } else {
                return CircularProgressIndicator();
              }
            }),
        Padding(
          key: Key('change-pw'),
          padding: EdgeInsets.only(
              top: 10,
              left: 90,
              right: 90,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            child: filledButton("Change password", Colors.white, Theme.of(context).primaryColor,
                Theme.of(context).primaryColor, Colors.white, () {
                  Navigator.pushNamed(context, '/password');
                }),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        //more to add
        SizedBox(
          height: 10,
        ),
        Padding(
          key: Key('friends'),
          padding: EdgeInsets.only(
              left: 90,
              right: 90,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            child: filledButton("Friends", Colors.white, Theme.of(context).primaryColor,
                Theme.of(context).primaryColor, Colors.white, () {
                  Navigator.pushNamed(context, '/friends/friends_page');
                }),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          key: Key('logout'),
          padding: EdgeInsets.only(
              left: 90,
              right: 90,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            child: filledButton("Logout", Colors.white, Theme.of(context).primaryColor,
                Theme.of(context).primaryColor, Colors.white, () async {
                  await _signOut();
                }),
            height: 40,
            width: MediaQuery.of(context).size.width,
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
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
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 50),
        Icon(
          Icons.person,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        SizedBox(width: 20),
        FashionFetishText(
          text: user != null ? '${user.displayName}' : '',
          size: 20,
          fontWeight: FashionFontWeight.normal,
          height: 1.05,
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 50),
        Icon(
          Icons.email,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        SizedBox(width: 20),
        FashionFetishText(
          text: user != null ? '${user.email}' : '',
          size: 20,
          fontWeight: FashionFontWeight.normal,
          height: 1.05,
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        SizedBox(width: 50),
        Icon(
          Icons.date_range,
          color: Theme.of(context).primaryColor,
          size: 40,
        ),
        SizedBox(width: 20),
        FashionFetishText(
          text: user != null
              ? '${DateFormat('dd.MM.yyyy').format(user.metadata.creationTime)}'
              : '',
          size: 20,
          fontWeight: FashionFontWeight.normal,
          height: 1.05,
        ),
      ]),
    ]);
  }
}
