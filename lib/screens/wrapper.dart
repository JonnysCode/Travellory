import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/authenticate/welcome.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/shared/loading_logo.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<UserModel>(context);
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);
    final FriendsProvider friendsProvider = Provider.of<FriendsProvider>(context, listen: false);

    // return either home or authentication
    if(user == null){
      return Welcome();
    } else {
      if(tripsProvider.user == null || tripsProvider.user != user){
        tripsProvider.init(user);
      }


//      if(friendsProvider.user == null || friendsProvider.user != user) {
//        friendsProvider.init(user);
//      }
//      return Home();

      return Selector<TripsProvider, bool>(
        selector: (_, tripsProvider) => tripsProvider.activeTripInitiated,
        builder: (_, initiated, __) => initiated
            ? Home()
            : LoadingLogo()
      );
    }
  }
}
