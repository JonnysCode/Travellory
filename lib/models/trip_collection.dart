import 'package:flutter/cupertino.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/trip_service.dart';

class TripCollection extends ChangeNotifier{
  TripCollection.init(String userUID){
    _getTrips(userUID);
  }

  List<TripModel> trips;
  // TODO: next upcoming trip
  // TODO: selected trip so we don't have to pass it via Navigator

  Future<void> _getTrips(String userUID) async{
    trips = await getTripsFromDatabase(userUID);
  }
}