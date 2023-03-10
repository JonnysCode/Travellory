import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:travellory/src/providers/auth_provider.dart';
import 'package:travellory/src/screens/achievements/view_achievements.dart';
import 'package:travellory/src/screens/authentication/password.dart';
import 'package:travellory/src/services/api/storage.dart';
import 'package:travellory/src/services/authentication/auth.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/components/shared/image_picker_handler.dart';
import 'package:travellory/src/components/shared/logger.dart';
import 'package:travellory/src/components/buttons/buttons.dart';
import 'package:travellory/src/components/buttons/option_button.dart';
import 'package:travellory/src/components/shared/section_titles.dart';
import 'package:travellory/src/components/profile/user_information.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin, ImagePickerListener {
  final log = getLogger('_ProfilePageState');

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
    imagePicker = ImagePickerHandler(this, _controller)..init();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user ??= Provider.of<UserModel>(context);
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
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 20,
                        color: Colors.black.withOpacity(.2),
                        offset: Offset(0.0, -6.0))
                  ],
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
                      child: Container(
                        height: 258.0,
                        width: 258.0,

                        /// profile picture with placeholder
                        child: CachedNetworkImage(
                          /// will check local cache first and download from firebase if necessary
                          imageUrl: user.photoUrl ?? defaultUserProfilePicture,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(image: imageProvider, fit: BoxFit.contain),
                                border:
                                    Border.all(color: Theme.of(context).primaryColor, width: 2.0),
                                borderRadius: BorderRadius.all(const Radius.circular(300.0))),
                          ),
                          placeholder: (context, url) => CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(Theme.of(context).primaryColor)),
                          errorWidget: (context, url, error) => const Icon(Icons.error),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                      child: SectionTitle(sectionTitle: 'User Information'),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
                        child: UserInformation(user: user)),
                    SizedBox(height: 10),
                    Padding(
                      key: Key('achievements'),
                      padding: EdgeInsets.only(
                          top: 10,
                          left: 90,
                          right: 90,
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      child: Container(
                        height: 40,
                        width: MediaQuery.of(context).size.width,
                        child: filledButton(
                            "Achievements",
                            Colors.white,
                            Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor,
                            Colors.white, () {
                          Navigator.pushNamed(context, AchievementsView.route);
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
          ),
          Positioned(
            top: 50,
            right: 35,
            child: OptionButton(
              optionItems: <OptionItem>[
                OptionItem(
                  description: 'Change password',
                  icon: FontAwesomeIcons.userEdit,
                  onTab: () => Navigator.pushNamed(context, ChangePassword.route),
                ),
                OptionItem(
                    description: 'Logout',
                    icon: FontAwesomeIcons.signOutAlt,
                    onTab: () async => {await _signOut()}),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void userImage(File _image) async {
    if (_image != null) {
      /// uploading file to the firebase storage
      final Storage storage = Storage();
      final String fileURL = await storage.uploadFile(_image, userProfilePicturesDir,
          filename: '$user.uid ${path.basename(_image.path)}');

      /// update variable photoUrl of current user with the returned fileURL from firebase
      final BaseAuthService _auth = AuthProvider.of(context).auth;
      final UserModel newUser = await _auth.updatePhotoUrl(fileURL);

      /// set this user in setState() for rebuilding widget.
      setState(() {
        user = newUser;
      });
    }
  }

  Future _signOut() async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
  }
}
