import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_collection.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/authenticate/welcome.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/services/trip_service.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<UserModel>(context);

    // return either home or authentication
    if(user == null){
      return Welcome();
    } else {
      return ChangeNotifierProvider<TripCollection>(
          create: (context) => TripCollection.init(user.uid),
          child: Home()
      );
    }
  }
}
