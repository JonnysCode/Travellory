import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user.dart';
import 'package:travellory/screens/wrapper.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/providers/auth_provider.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return AuthProvider(
      auth: AuthService(),
      child: StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Travellory',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Color(0xFFF72349),
            accentColor: Color(0xFFEFC2D1),
            scaffoldBackgroundColor: Color(0xFFF7E4E6),
          ),
          home: Wrapper(),
        ),
      ),
    );
  }
}