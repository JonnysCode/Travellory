import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/services/storage.dart';
import 'package:travellory/utils/image_picker_handler.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/logger.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin, ImagePickerListener {

  final log = getLogger('_ProfilePageState');

  File _image;
  AnimationController _controller;
  ImagePickerHandler imagePicker;
  UserModel user;

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
    if(this.user == null){
      this.user = Provider.of<UserModel>(context);
    }
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
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      key: Key('image_pick'),
                      onTap: () => imagePicker.showDialog(context),
                      child:  Container(
                        height: 258.0,
                        width: 258.0,
                        /// profile picture with placeholder
                        child: CachedNetworkImage(
                          /// will check local cache first and download from firebase if necessary
                          imageUrl: user.photoUrl == null ? Storage.DEFAULT_USER_PROFILE_PICTURES : user.photoUrl,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain
                              ),
                              border: Border.all(
                                  color: Theme.of(context).primaryColor, width: 2.0
                              ),
                              borderRadius: BorderRadius.all(const Radius.circular(300.0))
                            ),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: UserInformation(user: user)
                    ),
                    SizedBox(height: 10),
                    Padding(
                      key: Key('change-pw'),
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 90,
                          right: 90,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: filledButton("Change password", Colors.white, Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor, Colors.white, () {
                              Navigator.pushNamed(context, '/password');
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      key: Key('logout'),
                      padding: EdgeInsets.only(
                          left: 90,
                          right: 90,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: filledButton("Logout", Colors.white, Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor, Colors.white, () async {
                              await _signOut();
                            }),
                      ),
                    ),
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
  void userImage(File _image) async {
    if(_image != null){
      /// uploading file to the firebase storage
      String fileURL = await Storage.uploadFile(_image, Storage.USER_PROFILE_PICTURES, filename: this.user.uid+'_'+path.basename(_image.path));
      /// update variable photoUrl of current user with the returned fileURL from firebase
      final BaseAuthService _auth = AuthProvider.of(context).auth;
      UserModel newUser = await _auth.updatePhotoUrl(fileURL);
      /// set this user in setState() for rebuilding widget.
      setState(() {
        this.user = newUser;
      });
    }
  }

  Future _signOut() async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
    await Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}

class UserInformation extends StatelessWidget {
  const UserInformation({
    Key key,
    this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
        key: Key('display_user'),
        children: [
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.user,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                SizedBox(width: 10),
                FashionFetishText(
                  text: user.displayName != null ? user.displayName : '',
                  size: 18,
                  fontWeight: FashionFontWeight.bold,
                  height: 1.1,
                ),
              ]
          ),
          SizedBox(height: 8),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.envelope,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                SizedBox(width: 10),
                FashionFetishText(
                  text: user.email != null ? user.email : '',
                  size: 18,
                  fontWeight: FashionFontWeight.bold,
                  height: 1.1,
                ),
              ]
          ),
          SizedBox(height: 8),
          Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.calendarAlt,
                  color: Theme.of(context).primaryColor,
                  size: 32,
                ),
                SizedBox(width: 10),
                FashionFetishText(
                  text: user.metadata != null
                      ? DateFormat('dd.MM.yyyy').format(user.metadata.creationTime)
                      : '',
                  size: 18,
                  fontWeight: FashionFontWeight.bold,
                  height: 1.2,
                ),
              ]
          ),
        ]
    );
  }
}
