import 'package:flutter/material.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/notify_listener.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/edit_database.dart';
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
  List<SingleTripProvider> trips;
  bool isFetchingTrips = false;

  int _selectedTripIndex;
  int _activeTripIndex;
  bool _tripsInitiated = false;
  bool _activeTripInitiated = false;

  SingleTripProvider get activeTrip => trips[_activeTripIndex];

  SingleTripProvider get selectedTrip => trips[_selectedTripIndex];

  bool get activeTripInitiated => _activeTripInitiated;

  void init(UserModel user) {
    this.user = user;
    if(!_tripsInitiated){
      unawaited(_initTrips());
      _tripsInitiated = true;
    }
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
    unawaited(selectedTrip.initBookings());
  }

  @override
  void notify() {
    notifyListeners();
  }

  Future<void> _initTrips() async {
    await _fetchTrips();
    _setActiveTrip();
    await activeTrip.initBookings();
    activeTrip.initSchedule();
    _activeTripInitiated = true;
    notifyListeners();
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    List<TripModel> tripModels = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getTrips);
    trips = tripModels.map((tripModel) =>
        SingleTripProvider(tripModel, this)).toList();
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
    getDateTimeFrom(activeTrip.tripModel.endDate).isBefore(DateTime.now())
    );
  }
}