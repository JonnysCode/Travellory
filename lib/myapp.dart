import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/screens/authenticate/register.dart';
import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/screens/trip/trip_screen.dart';
import 'package:travellory/screens/wrapper.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/shared/loading.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      child: StreamProvider<UserModel>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Travellory',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.transparent,
            hintColor: Color(0xFFC0F0E8),
            primaryColor: Color(0xFF61BAA9),
            accentColor: Color(0xFFF72349),
            scaffoldBackgroundColor: Color(0xFFF0F4F4),
          ),
          routes: <String, Widget Function(BuildContext)>{
            '/': (context) => Wrapper(),
            '/auth': (context) => Authenticate(),
            '/login': (context) => SignIn(),
            '/register': (context) => Register(),
            '/loading': (context) => Loading(),
            '/home': (context) => Home(),
            '/viewtrip': (context) => TripScreen(),
            '/createtrip': (context) => CreateTripScreen(),
          },
        ),
      ),
    );
  }
}