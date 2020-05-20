import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/achievements_provider.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/authenticate/authenticate.dart';
import 'package:travellory/screens/authenticate/password.dart';
import 'package:travellory/screens/authenticate/register.dart';
import 'package:travellory/screens/authenticate/sign_in.dart';
import 'package:travellory/screens/bookings/temp_bookings.dart';
import 'package:travellory/screens/bookings/accommodation.dart';
import 'package:travellory/screens/bookings/activity.dart';
import 'package:travellory/screens/bookings/flight.dart';
import 'package:travellory/screens/bookings/public_transport.dart';
import 'package:travellory/screens/bookings/rental_car.dart';
import 'package:travellory/screens/bookings/view_accommodation.dart';
import 'package:travellory/screens/bookings/view_activity.dart';
import 'package:travellory/screens/bookings/view_flight.dart';
import 'package:travellory/screens/achievements/view_achievements.dart';
import 'package:travellory/screens/bookings/view_public_transport.dart';
import 'package:travellory/screens/bookings/view_rental_car.dart';
import 'package:travellory/screens/home/home.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/screens/trip/create_trip_screen.dart';
import 'package:travellory/screens/trip/trip_screen.dart';
import 'package:travellory/screens/wrapper.dart';
import 'package:travellory/services/authentication/auth.dart';
import 'package:travellory/screens/friends/friends_profile.dart';
import 'package:travellory/shared/loading_logo.dart';

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
          ChangeNotifierProvider<AchievementsProvider>(
              create: (context) => AchievementsProvider()),
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
            Wrapper.route: (_) => Wrapper(),
            Authenticate.route: (_) => Authenticate(),
            SignIn.route: (_) => SignIn(),
            Register.route: (_) => Register(),
            ChangePassword.route: (_) => ChangePassword(),
            LoadingLogo.route: (_) => LoadingLogo(),
            Home.route: (_) => Home(),
            TripScreen.route: (_) => TripScreen(),
            CreateTrip.route: (_) => CreateTrip(),
            RentalCar.route: (_) => RentalCar(),
            Accommodation.route: (_) => Accommodation(),
            Flight.route: (_) => Flight(),
            PublicTransport.route: (_) => PublicTransport(),
            Activity.route: (_) => Activity(),
            AccommodationView.route: (_) => AccommodationView(),
            FlightView.route: (_) => FlightView(),
            RentalCarView.route: (_) => RentalCarView(),
            PublicTransportView.route: (_) => PublicTransportView(),
            ActivityView.route: (_) => ActivityView(),
            AchievementsView.route: (_) => AchievementsView(),
            FriendsPage.route: (_) => FriendsPage(),
            FriendsProfile.route: (_) => FriendsProfile(),
            AddTempBookingsScreen.route: (_) => AddTempBookingsScreen(),
          },
        ),
      ),
    );
  }
}
