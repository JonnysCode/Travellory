import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/function_names.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:pedantic/pedantic.dart';

class TripsProvider extends ChangeNotifier{
  TripsProvider(){
   _trips = <TripModel>[];
  }

  List<TripModel> _trips;
  UserModel _user;
  bool isFetching = false;
  // TODO: next upcoming trip
  // TODO: selected trip so we don't have to pass it via Navigator

  List<TripModel> get trips => _trips;

  void init(UserModel user){
    _user = user;
    unawaited(fetchTrips());
  }

  Future<bool> addTrip(TripModel tripModel) async {
    tripModel.userUID = _user.uid;
    final DatabaseAdder databaseAdder = DatabaseAdder();
    final bool added = await databaseAdder.addModel(tripModel, FunctionName.addTrip);
    print('Have trips been added? '+ added.toString());
    if(added){
      unawaited(fetchTrips());
    }
    return added;
  }

  Future<void> fetchTrips() async {
    isFetching = true;
    _trips = await getTripsFromDatabase(_user.uid);
    isFetching = false;
    notifyListeners();
  }

}