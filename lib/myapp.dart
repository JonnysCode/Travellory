import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/screens/authenticate/password.dart';
import 'package:travellory/screens/authenticate/register.dart';
import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/screens/bookings/add_accommodation.dart';
import 'package:travellory/screens/bookings/add_activity.dart';
import 'package:travellory/screens/bookings/add_flight.dart';
import 'package:travellory/screens/bookings/add_public_transport.dart';
import 'package:travellory/screens/bookings/add_rental_car.dart';
import 'package:travellory/screens/bookings/view_accommodation.dart';
import 'package:travellory/screens/bookings/view_activity.dart';
import 'package:travellory/screens/bookings/view_flight.dart';
import 'package:travellory/screens/bookings/view_public_transport.dart';
import 'package:travellory/screens/bookings/view_rental_car.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/screens/trip/trip_screen.dart';
import 'package:travellory/screens/wrapper.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/shared/loading.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<TripsProvider>(
              create: (context) => TripsProvider()),
          ChangeNotifierProvider<FriendsProvider>(
              create: (context) => FriendsProvider()),
          StreamProvider<UserModel>.value(value: AuthService().user),
        ],
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
            '/password': (context) => ChangePassword(),
            '/loading': (context) => Loading(),
            '/home': (context) => Home(),
            '/viewtrip': (context) => TripScreen(),
            '/createtrip': (context) => CreateTrip(),
            '/booking/rentalcar': (context) => RentalCar(),
            '/booking/accommodation': (context) => Accommodation(),
            '/booking/flight': (context) => Flight(),
            '/booking/publictransport': (context) => PublicTransport(),
            '/booking/activity': (context) => Activity(),
            '/view/accommodation': (context) => AccommodationView(),
            '/view/flight': (context) => FlightView(),
            '/view/rentalcar': (context) => RentalCarView(),
            '/view/publictransport': (context) => PublicTransportView(),
            '/view/activity': (context) => ActivityView(),
            '/friends/friends_page': (context) => FriendsPage(),
          },
        ),
      ),
    );
  }
}
