import 'package:flutter/material.dart';
import 'package:travellory/src/services/authentication/auth.dart';

class AuthProvider extends InheritedWidget {
  const AuthProvider({Key key, Widget child, this.auth}) : super(key: key, child: child);
  final BaseAuthService auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType();
  }
}