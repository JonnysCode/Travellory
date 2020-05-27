import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/components/profile/profile_homecountry.dart';
import 'package:flutter/material.dart';
import '../shared/font_widgets.dart';

/// displays user name, user e-mail address
/// and user home country which can be edited
class UserInformation extends StatelessWidget {
  const UserInformation({
    Key key,
    this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      key: Key('display_user'),
      child: Column(children: <Widget>[
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
                text: user != null ? user.displayName : '',
                size: 18,
                fontWeight: FashionFontWeight.bold,
                height: 1.1,
              ),
            ]),
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
                text: user != null ? user.email : '',
                size: 18,
                fontWeight: FashionFontWeight.bold,
                height: 1.1,
              ),
            ]),
        ProfileHomeCountry(user: user),
      ]),
    );
  }
}
