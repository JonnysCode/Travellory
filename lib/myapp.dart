import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/screens/authenticate/password.dart';
import 'package:travellory/screens/authenticate/register.dart';
import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/screens/friends/friends_page.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/screens/trip/bookings/accommodation.dart';
import 'package:travellory/screens/trip/bookings/activity.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/screens/trip/bookings/flight.dart';
import 'package:travellory/screens/trip/bookings/public_transport.dart';
import 'package:travellory/screens/trip/bookings/rental_car.dart';
import 'package:travellory/screens/trip/trip_screen.dart';
import 'package:travellory/screens/wrapper.dart';
import 'package:travellory/services/auth.dart';
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
            scaffoldBackgroundColor: Color(0xFFE6E6E6),
          ),
          routes: <String, Widget Function(BuildContext)>{
            '/': (context) => Wrapper(),
            '/auth': (context) => Authenticate(),
            '/login': (context) => SignIn(),
            '/register': (context) => Register(),
            '/password': (context) => ChangePassword(),
            '/loading': (context) => Loading(),
            '/home': (context) => Home(),
            '/viewtrip': (context) => TripScreen(),
            '/createtrip': (context) => CreateTrip(),
            '/booking/rentalCar': (context) => RentalCar(),
            '/booking/accommodation': (context) => Accommodation(),
            '/booking/flight': (context) => Flight(),
            '/booking/publicTransport': (context) => PublicTransport(),
            '/booking/activity': (context) => Activity(),
            '/friends/friends_page': (context) => FriendsPage(),
          },
        ),
      ),
    );
  }
}