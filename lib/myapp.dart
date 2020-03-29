import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:travellory/models/user.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/screens/authenticate/register.dart';
import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/screens/trip/accommodation.dart';
import 'package:travellory/screens/trip/activity.dart';
import 'package:travellory/screens/trip/flight.dart';
import 'package:travellory/screens/trip/publicTransport.dart';
import 'package:travellory/screens/trip/rentalCar.dart';
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
      child: StreamProvider<User>.value(
        value: AuthService().user,
        child: MaterialApp(
          title: 'Travellory',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: Colors.transparent,
            hintColor: Color(0xFFC0F0E8),
            primaryColor: Color(0xFF61BAA9),
            // accentColor: Color(0xFFF72349),
            accentColor: Color(0xFFF48FB1),
            scaffoldBackgroundColor: Color(0xFFE6E6E6),
          ),
          localizationsDelegates: [
            // the localizationsDelegates is used for the datepicker
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
            // used for the datepicker
            const Locale('en', 'US'), // English
            const Locale('de', 'CH'), // German Switzerland
          ],
          routes: {
            '/': (BuildContext context) => Wrapper(),
            '/auth': (BuildContext context) => Authenticate(),
            '/login': (BuildContext context) => SignIn(),
            '/register': (BuildContext context) => Register(),
            '/loading': (BuildContext context) => Loading(),
            '/home': (BuildContext context) => Home(),
            '/viewtrip': (BuildContext context) => TripScreen(),
            '/booking/rentalCar': (BuildContext context) => RentalCar(),
            '/booking/accommodation': (BuildContext context) => Accommodation(),
            '/booking/flight': (BuildContext context) => Flight(),
            '/booking/publicTransport': (BuildContext context) => PublicTransport(),
            '/booking/activity': (BuildContext context) => Activity(),
          },
        ),
      ),
    );
  }
}