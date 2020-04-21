import 'package:flutter/material.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:pedantic/pedantic.dart';

class TripsProvider extends ChangeNotifier {
  TripsProvider() {
    _trips = <TripModel>[];
    _flights = <FlightModel>[];
    _accommodations = <AccommodationModel>[];
    _rentalcars = <RentalCarModel>[];
    _publictransports = <PublicTransportModel>[];
  }

  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseGetter _databaseGetter = DatabaseGetter();

  bool isFetching = false;

  List<TripModel> _trips;
  List<FlightModel> _flights;
  List<AccommodationModel> _accommodations;
  List<RentalCarModel> _rentalcars;
  List<PublicTransportModel> _publictransports;
  UserModel _user;

  // TODO: next upcoming trip
  // TODO: selected trip so we don't have to pass it via Navigator

  List<TripModel> get trips => _trips;

  List<FlightModel> get flights => _flights;

  List<AccommodationModel> get accommodations => _accommodations;

  List<RentalCarModel> get rentalcars => _rentalcars;

  List<PublicTransportModel> get publictransports => _publictransports;

  set user(UserModel user) {
    _user = user;
  }

  void init(UserModel user) {
    _user = user;
    unawaited(_fetchTrips());
  }

  Future<bool> addTrip(TripModel tripModel) async {
    tripModel.userUID = _user.uid;
    final bool added =
        await _databaseAdder.addModel(tripModel, _databaseAdder.addTrip);
    if (added) {
      unawaited(_fetchTrips());
    }
    return added;
  }

  Future<void> _fetchTrips() async {
    isFetching = true;
    _trips = await _databaseGetter.getEntriesFromDatabase(
        _user.uid, _databaseGetter.getTrips);
    isFetching = false;
    notifyListeners();
  }

  Future<void> initBookings(TripModel trip) async {
    await _fetchBookings(trip.uid);
  }

  Future<void> _fetchBookings(String tripUID) async {
    isFetching = true;
    _flights = await _databaseGetter.getEntriesFromDatabase(
        tripUID, _databaseGetter.getFlights);
    _accommodations = await _databaseGetter.getEntriesFromDatabase(
        tripUID, _databaseGetter.getAccommodations);
    _rentalcars = await _databaseGetter.getEntriesFromDatabase(
        tripUID, _databaseGetter.getRentalCars);
    _publictransports = await _databaseGetter.getEntriesFromDatabase(
        tripUID, _databaseGetter.getPublicTransportations);
    isFetching = false;
    notifyListeners();
  }
}
