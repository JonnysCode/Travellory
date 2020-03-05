import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    print(user);

    // return either home or authenticate widget
    if(user == null){
      return Authenticate();
    } else {
      return Home();
    }
  }
}
