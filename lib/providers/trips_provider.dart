import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/get_database.dart';

class TripsProvider extends ChangeNotifier{
  TripsProvider();

  // Factory constructor fetching the trips
  // from the db and returning it as a future
  static Future<TripsProvider> init(UserModel user) async {
    var tripsProvider = TripsProvider();
    tripsProvider._user = user;
    tripsProvider._trips = await getTripsFromDatabase(user.uid);
    return tripsProvider;
  }

  List<TripModel> _trips;
  UserModel _user;
  // TODO: next upcoming trip
  // TODO: selected trip so we don't have to pass it via Navigator

  List<TripModel> get trips => _trips;

  Future<void> fetchTrips() async {
    _trips = await getTripsFromDatabase(_user.uid);
    notifyListeners();
  }

}