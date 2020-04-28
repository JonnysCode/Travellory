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
  int _selectedTripIndex;
  int _activeTripIndex;

  List<TripModel> get trips => _trips;

  List<FlightModel> get flights => _flights;

  List<AccommodationModel> get accommodations => _accommodations;

  List<ActivityModel> get activities => _activities;

  List<RentalCarModel> get rentalcars => _rentalCars;

  List<PublicTransportModel> get publictransports => _publicTransports;

  TripModel get activeTrip => _trips[_activeTripIndex];

  TripModel get selectedTrip => _trips[_selectedTripIndex];

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
        unawaited(_fetchFlights(_selectedTripIndex));
      } else if (model is RentalCarModel){
        unawaited(_fetchRentalCars(_selectedTripIndex));
      } else if (model is AccommodationModel){
        unawaited(_fetchAccommodation(_selectedTripIndex));
      } else if (model is PublicTransportModel){
        unawaited(_fetchPublicTransportation(_selectedTripIndex));
      } else if (model is ActivityModel){
        unawaited(_fetchActivities(_selectedTripIndex));
      }
    }
    return added;
  }

  Future<void> initBookings(int tripIndex) async {
    unawaited(_fetchFlights(tripIndex));
    unawaited(_fetchAccommodation(tripIndex));
    unawaited(_fetchActivities(tripIndex));
    unawaited(_fetchPublicTransportation(tripIndex));
    unawaited(_fetchRentalCars(tripIndex));
  }

  void selectTrip(TripModel tripModel){
    _selectedTripIndex = _trips.indexWhere((trip) => trip.uid == tripModel.uid);
    initBookings(_selectedTripIndex);
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    _trips = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getTrips);
    _setActiveTrip();
    isFetchingTrips = false;
    notifyListeners();
  }

  Future<void> _fetchFlights(int tripIndex) async {
    isFetchingFlights = true;
    _flights = await _databaseGetter.getEntriesFromDatabase(
        _trips[tripIndex].uid, DatabaseGetter.getFlights);
    isFetchingFlights = false;
    notifyListeners();
  }

  Future<void> _fetchAccommodation(int tripIndex) async {
    isFetchingAccommodations = true;
    _accommodations = await _databaseGetter.getEntriesFromDatabase(
        _trips[tripIndex].uid, DatabaseGetter.getAccommodations);
    isFetchingAccommodations = false;
    notifyListeners();
  }

  Future<void> _fetchActivities(int tripIndex) async {
    isFetchingActivities = true;
    _activities = await _databaseGetter.getEntriesFromDatabase(
        _trips[tripIndex].uid, DatabaseGetter.getActivities);
    isFetchingActivities = false;
    notifyListeners();
  }

  Future<void> _fetchRentalCars(int tripIndex) async {
    isFetchingRentalCars = true;
    _rentalCars = await _databaseGetter.getEntriesFromDatabase(
        _trips[tripIndex].uid, DatabaseGetter.getRentalCars);
    isFetchingRentalCars = false;
    notifyListeners();
  }

  Future<void> _fetchPublicTransportation(int tripIndex) async {
    isFetchingPublicTransport = true;
    _publicTransports = await _databaseGetter.getEntriesFromDatabase(
        _trips[tripIndex].uid, DatabaseGetter.getPublicTransportations);
    isFetchingPublicTransport = false;
    notifyListeners();
  }

  void _setActiveTrip(){
    int index = 0;
    // get the first trip with an end date after the current date
    do {
      _activeTripIndex = index;
      index++;
    } while(
      getDateTimeFrom(_trips[_activeTripIndex].endDate).isBefore(DateTime.now())
    );
  }

}
