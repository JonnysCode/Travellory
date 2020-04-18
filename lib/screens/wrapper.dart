import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/authenticate/welcome.dart';
import 'package:travellory/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserModel user = Provider.of<UserModel>(context);

    // return either home or authentication
    if(user == null){
      return Welcome();
    } else {
      return FutureProvider<TripsProvider>(
          create: (context) => TripsProvider.init(user),
          child: Home()
      );
    }
  }
}
