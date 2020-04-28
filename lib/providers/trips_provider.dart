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

  UserModel user;
  int _selectedTripIndex;
  int _activeTripIndex;

  List<TripModel> get trips => _trips;

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
      var trip = _trips[_selectedTripIndex];
      if (model is FlightModel){
        unawaited(_fetchFlights(trip));
      } else if (model is RentalCarModel){
        unawaited(_fetchRentalCars(trip));
      } else if (model is AccommodationModel){
        unawaited(_fetchAccommodation(trip));
      } else if (model is PublicTransportModel){
        unawaited(_fetchPublicTransportation(trip));
      } else if (model is ActivityModel){
        unawaited(_fetchActivities(trip));
      }
    }
    return added;
  }

  void selectTrip(TripModel tripModel){
    _selectedTripIndex = _trips.indexWhere((trip) => trip.uid == tripModel.uid);
    _initBookings(_selectedTripIndex);
  }

  Future<void> _initBookings(int tripIndex) async {
    var trip = _trips[tripIndex];
    unawaited(_fetchFlights(trip));
    unawaited(_fetchAccommodation(trip));
    unawaited(_fetchActivities(trip));
    unawaited(_fetchPublicTransportation(trip));
    unawaited(_fetchRentalCars(trip));
  }

  Future<void> _fetchTrips() async {
    isFetchingTrips = true;
    _trips = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getTrips);
    _setActiveTrip();
    isFetchingTrips = false;
    notifyListeners();
  }

  Future<void> _fetchFlights(TripModel trip) async {
    isFetchingFlights = true;
    trip.flights = await _databaseGetter.getEntriesFromDatabase(
        trip.uid, DatabaseGetter.getFlights);
    isFetchingFlights = false;
    notifyListeners();
  }

  Future<void> _fetchAccommodation(TripModel trip) async {
    isFetchingAccommodations = true;
    trip.accommodations = await _databaseGetter.getEntriesFromDatabase(
        trip.uid, DatabaseGetter.getAccommodations);
    isFetchingAccommodations = false;
    notifyListeners();
  }

  Future<void> _fetchActivities(TripModel trip) async {
    isFetchingActivities = true;
    trip.activities = await _databaseGetter.getEntriesFromDatabase(
        trip.uid, DatabaseGetter.getActivities);
    isFetchingActivities = false;
    notifyListeners();
  }

  Future<void> _fetchRentalCars(TripModel trip) async {
    isFetchingRentalCars = true;
    trip.rentalCars = await _databaseGetter.getEntriesFromDatabase(
        trip.uid, DatabaseGetter.getRentalCars);
    isFetchingRentalCars = false;
    notifyListeners();
  }

  Future<void> _fetchPublicTransportation(TripModel trip) async {
    isFetchingPublicTransport = true;
    trip.publicTransports = await _databaseGetter.getEntriesFromDatabase(
        trip.uid, DatabaseGetter.getPublicTransportations);
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
