import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

List<Widget> profilePage(BuildContext context){
  return [
    FlatButton.icon(
      onPressed: () => _signOut(context),
      icon: Icon(Icons.person),
      label: Text('logout'),
    )
  ];
}

Future _signOut(BuildContext context) async {
  final BaseAuthService _auth = AuthProvider.of(context).auth;
  await _auth.signOut();
}