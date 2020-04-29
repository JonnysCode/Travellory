import 'package:pedantic/pedantic.dart';
import 'package:travellory/models/abstract_model.dart';

import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/get_database.dart';

class SingleTripProvider {
  SingleTripProvider(TripModel trip, DatabaseGetter databaseGetter, DatabaseAdder databaseAdder){
    this.tripModel = trip;
    this.databaseGetter = databaseGetter;
    this.databaseAdder = databaseAdder;

    flights = <FlightModel>[];
    accommodations = <AccommodationModel>[];
    activities = <ActivityModel>[];
    rentalCars = <RentalCarModel>[];
    publicTransports = <PublicTransportModel>[];
  }

  DatabaseGetter databaseGetter;
  DatabaseAdder databaseAdder;

  TripModel tripModel;
  bool isFetching = false;

  List<FlightModel> flights;
  List<AccommodationModel> accommodations;
  List<ActivityModel> activities;
  List<RentalCarModel> rentalCars;
  List<PublicTransportModel> publicTransports;
  bool isFetchingFlights = false;
  bool isFetchingAccommodations = false;
  bool isFetchingActivities = false;
  bool isFetchingRentalCars = false;
  bool isFetchingPublicTransports = false;


  Future<void> initBookings() async {
    unawaited(_fetchFlights());
    unawaited(_fetchAccommodation());
    unawaited(_fetchActivities());
    unawaited(_fetchPublicTransportation());
    unawaited(_fetchRentalCars());
  }

  Future<bool> addBooking(Model model, String functionName) async {
    final bool added = await databaseAdder.addModel(model, functionName);
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

  Future<void> _fetchFlights() async {
    isFetchingFlights = true;
    flights = await databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getFlights);
    isFetchingFlights = false;
  }

  Future<void> _fetchAccommodation() async {
    isFetchingAccommodations = true;
    accommodations = await databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getAccommodations);
    isFetchingAccommodations = false;
  }

  Future<void> _fetchActivities() async {
    isFetchingActivities = true;
    activities = await databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getActivities);
    isFetchingActivities = false;
  }

  Future<void> _fetchRentalCars() async {
    isFetchingRentalCars = true;
    rentalCars = await databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getRentalCars);
    isFetchingRentalCars = false;
  }

  Future<void> _fetchPublicTransportation() async {
    isFetchingPublicTransports = true;
    publicTransports = await databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getPublicTransportations);
    isFetchingPublicTransports = false;
  }
}