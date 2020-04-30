import 'package:flutter/material.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/NotifyListener.dart';
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
//  final DatabaseDeleter _databaseDeleter = DatabaseDeleter();
//  final DatabaseEditor _databaseEditor = DatabaseEditor();

  UserModel user;
  bool isFetchingTrips = false;
  List<SingleTripProvider> trips;

  int _selectedTripIndex;
  int _activeTripIndex;
  bool _tripsInitiated = false;

  SingleTripProvider get activeTrip => trips[_activeTripIndex];

  SingleTripProvider get selectedTrip => trips[_selectedTripIndex];

  ActivityModel selectedActivity;

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
    selectedTrip.initBookings();
  }

  Future<void> _initTrips() async {
    await _fetchTrips();
    _setActiveTrip();
    await activeTrip.initBookings();

//  Future<bool> deleteModel(Model model, String functionName) async {
//    final bool deleted = await _databaseDeleter.deleteModel(model, functionName);
//    if (deleted) {
//      if (model is FlightModel){
//        unawaited(_fetchFlights());
//      } else if (model is RentalCarModel){
//        unawaited(_fetchRentalCars());
//      } else if (model is AccommodationModel){
//        unawaited(_fetchAccommodation());
//      } else if (model is PublicTransportModel){
//        unawaited(_fetchPublicTransportation());
//      } else if (model is ActivityModel){
//        unawaited(_fetchActivities());
//      }
//    }
//    return deleted;
//  }

//  Future<bool> editModel(Model model, String functionName) async {
//    final bool edited = await _databaseEditor.editModel(model, functionName);
//    if (edited) {
//      if (model is FlightModel){
//        unawaited(_fetchFlights());
//      } else if (model is RentalCarModel){
//        unawaited(_fetchRentalCars());
//      } else if (model is AccommodationModel){
//        unawaited(_fetchAccommodation());
//      } else if (model is PublicTransportModel){
//        unawaited(_fetchPublicTransportation());
//      } else if (model is ActivityModel){
//        unawaited(_fetchActivities());
//      }
//    }
//    return edited;
//  }

//  Future<void> initBookings() async {
//    unawaited(_fetchFlights());
//    unawaited(_fetchAccommodation());
//    unawaited(_fetchActivities());
//    unawaited(_fetchPublicTransportation());
//    unawaited(_fetchRentalCars());
//  }

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

  @override
  void notify() {
    notifyListeners();
  }

}