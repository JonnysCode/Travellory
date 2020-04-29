import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/utils/date_converter.dart';

class TripsProvider extends ChangeNotifier {
  TripsProvider() {
    _trips = <SingleTripProvider>[];
  }

  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseGetter _databaseGetter = DatabaseGetter();


  UserModel user;
  bool isFetchingTrips = false;

  List<SingleTripProvider> _trips;
  int _selectedTripIndex;
  int _activeTripIndex;

  List<SingleTripProvider> get trips => _trips;

  SingleTripProvider get activeTrip => _trips[_activeTripIndex];

  SingleTripProvider get selectedTrip => _trips[_selectedTripIndex];

  void init(UserModel user) {
    this.user = user;
    unawaited(_fetchTrips());

  }

  Future<bool> addTrip(TripModel tripModel) async {
    tripModel.userUID = user.uid;
    final bool added =
        await _databaseAdder.addModel(tripModel, DatabaseAdder.addTrip);
    if (added) {
      unawaited(_fetchTrips());
    }
    return added;
  }

  void selectTrip(TripModel tripModel){
    _selectedTripIndex = _trips.indexWhere((entry) => entry.tripModel.uid == tripModel.uid);
    _trips[_selectedTripIndex].initBookings();
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    List<TripModel> tripModels = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getTrips);
    _trips = tripModels.map((tripModel) => SingleTripProvider(
        tripModel, _databaseGetter, _databaseAdder)).toList();

    _setActiveTrip();
    isFetchingTrips = false;
    notifyListeners();
  }

  void _setActiveTrip(){
    int index = 0;
    // get the first trip with an end date after the current date
    do {
      _activeTripIndex = index;
      index++;
    } while(
      getDateTimeFrom(_trips[_activeTripIndex].tripModel.endDate).isBefore(DateTime.now())
    );
  }

}
