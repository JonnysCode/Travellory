import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/utils/date_converter.dart';

class TripsProvider extends ChangeNotifier {
  TripsProvider() {
    _trips = <TripModel>[];
    _flights = <FlightModel>[];
    _accommodations = <AccommodationModel>[];
    _activities = <ActivityModel>[];
    _rentalCars = <RentalCarModel>[];
    _publicTransports = <PublicTransportModel>[];
  }

  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseGetter _databaseGetter = DatabaseGetter();

  bool isFetchingTrips = false;
  bool isFetchingFlights = false;
  bool isFetchingAccommodations = false;
  bool isFetchingActivities = false;
  bool isFetchingRentalCars = false;
  bool isFetchingPublicTransport = false;

  List<TripModel> _trips;
  List<FlightModel> _flights;
  List<AccommodationModel> _accommodations;
  List<ActivityModel> _activities;
  List<RentalCarModel> _rentalCars;
  List<PublicTransportModel> _publicTransports;

  UserModel user;
  TripModel selectedTrip;
  TripModel activeTrip;

  List<TripModel> get trips => _trips;

  List<FlightModel> get flights => _flights;

  List<AccommodationModel> get accommodations => _accommodations;

  List<ActivityModel> get activities => _activities;

  List<RentalCarModel> get rentalcars => _rentalCars;

  List<PublicTransportModel> get publictransports => _publicTransports;


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

  Future<bool> addModel(Model model, String functionName) async {
    final bool added = await _databaseAdder.addModel(model, functionName);
    if (added) {
      if (model is FlightModel){
        unawaited(_fetchFlights());
      } else if (model is RentalCarModel){
        unawaited(_fetchRentalCars());
      } else if (model is AccommodationModel){
        unawaited(_fetchAccommodation());
      } else if (model is PublicTransportModel){
        unawaited(_fetchPublicTransportation());
      } else if (model is ActivityModel){
        unawaited(_fetchActivities());
      }
    }
    return added;
  }

  Future<void> initBookings() async {
    unawaited(_fetchFlights());
    unawaited(_fetchAccommodation());
    unawaited(_fetchActivities());
    unawaited(_fetchPublicTransportation());
    unawaited(_fetchRentalCars());
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    _trips = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getTrips);
    _setActiveTrip();
    isFetchingTrips = false;
    notifyListeners();
  }

  Future<void> _fetchFlights() async {
    isFetchingFlights = true;
    _flights = await _databaseGetter.getEntriesFromDatabase(
        selectedTrip.uid, DatabaseGetter.getFlights);
    isFetchingFlights = false;
    notifyListeners();
  }

  Future<void> _fetchAccommodation() async {
    isFetchingAccommodations = true;
    _accommodations = await _databaseGetter.getEntriesFromDatabase(
        selectedTrip.uid, DatabaseGetter.getAccommodations);
    isFetchingAccommodations = false;
    notifyListeners();
  }

  Future<void> _fetchActivities() async {
    isFetchingActivities = true;
    _activities = await _databaseGetter.getEntriesFromDatabase(
        selectedTrip.uid, DatabaseGetter.getActivities);
    isFetchingActivities = false;
    notifyListeners();
  }

  Future<void> _fetchRentalCars() async {
    isFetchingRentalCars = true;
    _rentalCars = await _databaseGetter.getEntriesFromDatabase(
        selectedTrip.uid, DatabaseGetter.getRentalCars);
    isFetchingRentalCars = false;
    notifyListeners();
  }

  Future<void> _fetchPublicTransportation() async {
    isFetchingPublicTransport = true;
    _publicTransports = await _databaseGetter.getEntriesFromDatabase(
        selectedTrip.uid, DatabaseGetter.getPublicTransportations);
    isFetchingPublicTransport = false;
    notifyListeners();
  }

  void _setActiveTrip(){
    if(_trips.isEmpty){
      return;
    }

    int index = 1;
    activeTrip = _trips[0];
    // get the first trip with an end date after the current date
    while(getDateTimeFrom(activeTrip.endDate).isBefore(DateTime.now())){
      activeTrip = _trips[index];
      index++;
    }
  }

}
