import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/NotifyListener.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/utils/date_converter.dart';

class TripsProvider extends ChangeNotifier implements NotifyListener{
  TripsProvider() {
    trips = <SingleTripProvider>[];
  }

  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseGetter _databaseGetter = DatabaseGetter();

  UserModel user;
  bool isFetchingTrips = false;
  List<SingleTripProvider> trips;

  int _selectedTripIndex;
  int _activeTripIndex;

  SingleTripProvider get activeTrip => trips[_activeTripIndex];

  SingleTripProvider get selectedTrip => trips[_selectedTripIndex];

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
    _selectedTripIndex = trips.indexWhere((entry) => entry.tripModel.uid == tripModel.uid);
    trips[_selectedTripIndex].initBookings();
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    List<TripModel> tripModels = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getTrips);
    trips = tripModels.map((tripModel) => SingleTripProvider(
        tripModel, _databaseGetter, _databaseAdder, this)).toList();

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
      getDateTimeFrom(trips[_activeTripIndex].tripModel.endDate).isBefore(DateTime.now())
    );
  }

  @override
  void notify() {
    notifyListeners();
  }

}
