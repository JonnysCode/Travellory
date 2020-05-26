import 'package:flutter/material.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:travellory/src/providers/abstract_notify_listener.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/services/cloud/add_database.dart';
import 'package:travellory/src/services/cloud/delete_database.dart';
import 'package:travellory/src/services/cloud/edit_database.dart';
import 'package:travellory/src/services/cloud/get_database.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/src/utils/date_handler.dart';

class TripsProvider extends ChangeNotifier implements NotifyListener {
  TripsProvider() {
    trips = <SingleTripProvider>[];
  }

  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseGetter _databaseGetter = DatabaseGetter();
  final DatabaseDeleter _databaseDeleter = DatabaseDeleter();
  final DatabaseEditor _databaseEditor = DatabaseEditor();

  UserModel user;
  List<SingleTripProvider> trips;
  bool isFetchingTrips = false;

  int _selectedTripIndex;
  int _activeTripIndex;
  bool _tripsInitiated = false;
  bool _activeTripInitiated = false;

  SingleTripProvider get activeTrip => _activeTripIndex == null ? null : trips[_activeTripIndex];

  SingleTripProvider get selectedTrip => trips[_selectedTripIndex];

  bool get activeTripInitiated => _activeTripInitiated;

  /// Initiate the TripProvider and select the active trip.
  ///
  /// Fetches all trips from the database, sorts them after
  /// its startDate and initiates the upcoming one. Meaning
  /// it fetches all its Bookings from the database as well.
  void init(UserModel user) {
    this.user = user;
    if (!_tripsInitiated) {
      unawaited(_initTrips());
      _tripsInitiated = true;
    }
  }

  Future<bool> addTrip(TripModel tripModel) async {
    tripModel.userUID = user.uid;
    final bool added = await _databaseAdder.addModel(tripModel, DatabaseAdder.addTrip);
    if (added) {
      unawaited(_initTrips());
    }
    return added;
  }

  Future<bool> deleteTrip(TripModel tripModel) async {
    final bool deleted =
        await _databaseDeleter.deleteModel(tripModel, DatabaseDeleter.deleteTrip);
    if (deleted) {
      await _initTrips();
    }
    return deleted;
  }

  Future<bool> editTrip(TripModel tripModel) async {
    final bool edited = await _databaseEditor.editModel(tripModel, DatabaseEditor.editTripName);
    if (edited) {
      await _initTrips();
      selectTrip(tripModel);
    }
    return edited;
  }

  void selectTrip(TripModel tripModel) {
    _selectedTripIndex = trips.indexWhere((entry) => entry.tripModel.uid == tripModel.uid);
    unawaited(selectedTrip.initBookings());
  }

  @override
  void notify() {
    notifyListeners();
  }

  Future<void> _initTrips() async {
    await _fetchTrips();
    _activeTripIndex = null;
    _selectedTripIndex = null;
    _setActiveTrip();
    if (_activeTripIndex != null) {
      await activeTrip.initBookings();
    }
    _activeTripInitiated = true;
    notifyListeners();
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    trips = <SingleTripProvider>[];
    final List<TripModel> tripModels =
        await _databaseGetter.getEntriesFromDatabase(user.uid, DatabaseGetter.getTrips);
    trips = tripModels.map((tripModel) => SingleTripProvider(tripModel, this)).toList();
    trips.sort((a, b) =>
        getDateTimeFrom(a.tripModel.startDate).compareTo(getDateTimeFrom(b.tripModel.startDate)));
    isFetchingTrips = false;
    notifyListeners();
  }

  void _setActiveTrip() {
    if (trips.isEmpty) {
      return;
    }
    // the last trip ends before the current Date
    if (getDateTimeFrom(trips.last.tripModel.endDate).isBefore(DateTime.now())) {
      return;
    }

    int index = 0;
    // get the first trip with an end date after the current date
    do {
      _activeTripIndex = index;
      index++;
    } while (getDateTimeFrom(activeTrip.tripModel.endDate).isBefore(DateTime.now()));
  }
}
