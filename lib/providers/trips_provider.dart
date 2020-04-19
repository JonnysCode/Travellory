import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:pedantic/pedantic.dart';

class TripsProvider extends ChangeNotifier{
  TripsProvider(){
   _trips = <TripModel>[];
  }
  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseGetter _databaseGetter = DatabaseGetter();

  bool isFetching = false;

  List<TripModel> _trips;
  UserModel _user;
  // TODO: next upcoming trip
  // TODO: selected trip so we don't have to pass it via Navigator

  List<TripModel> get trips => _trips;

  set user(UserModel user){
    _user = user;
  }

  void init(UserModel user){
    _user = user;
    unawaited(_fetchTrips());
  }

  Future<bool> addTrip(TripModel tripModel) async {
    tripModel.userUID = _user.uid;
    final bool added = await _databaseAdder.addModel(tripModel, _databaseAdder.addTrip);
    if(added){
      unawaited(_fetchTrips());
    }
    return added;
  }

  Future<void> _fetchTrips() async {
    isFetching = true;
    _trips = await _databaseGetter.getTripsFromDatabase(_user.uid);
    isFetching = false;
    notifyListeners();
  }
}