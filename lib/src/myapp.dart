import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/providers/achievements_provider.dart';
import 'package:travellory/src/providers/auth_provider.dart';
import 'package:travellory/src/providers/friends_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/screens/authentication/authenticate.dart';
import 'package:travellory/src/screens/authentication/password.dart';
import 'package:travellory/src/screens/authentication/register.dart';
import 'package:travellory/src/screens/authentication/sign_in.dart';
import 'package:travellory/src/screens/temp_bookings/temp_bookings.dart';
import 'package:travellory/src/screens/accommodation/accommodation.dart';
import 'package:travellory/src/screens/activity/activity.dart';
import 'package:travellory/src/screens/flight/flight.dart';
import 'package:travellory/src/screens/public_transport/public_transport.dart';
import 'package:travellory/src/screens/rental_car/rental_car.dart';
import 'package:travellory/src/screens/accommodation/view_accommodation.dart';
import 'package:travellory/src/screens/activity/view_activity.dart';
import 'package:travellory/src/screens/flight/view_flight.dart';
import 'package:travellory/src/screens/achievements/view_achievements.dart';
import 'package:travellory/src/screens/public_transport/view_public_transport.dart';
import 'package:travellory/src/screens/rental_car/view_rental_car.dart';
import 'package:travellory/src/screens/home.dart';
import 'package:travellory/src/screens/main/friends_page.dart';
import 'package:travellory/src/screens/trip/create_trip_screen.dart';
import 'package:travellory/src/screens/trip/trip_screen.dart';
import 'package:travellory/src/screens/wrapper.dart';
import 'package:travellory/src/services/authentication/auth.dart';
import 'package:travellory/src/screens/friends/friends_profile.dart';
import 'package:travellory/src/services/cloud/friend_management.dart';
import 'package:travellory/src/components/animations/loading_heart.dart';
import 'package:travellory/src/components/animations/loading_logo.dart';

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
              create: (context) =>
                  FriendsProvider(management: FriendManagement())),
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
            LoadingHeart.route: (_) => LoadingHeart(),
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
