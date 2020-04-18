import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/trip_service.dart';

class TripsProvider extends ChangeNotifier{
  TripsProvider();

  // Factory constructor fetching the trips
  // from the db and returning it as a future
  static Future<TripsProvider> init(String userUID) async {
    var tripsProvider = TripsProvider();
    tripsProvider._trips = await getTripsFromDatabase(userUID);
    return tripsProvider;
  }

  List<TripModel> _trips;
  // TODO: next upcoming trip
  // TODO: selected trip so we don't have to pass it via Navigator

  List<TripModel> get trips => _trips;


}