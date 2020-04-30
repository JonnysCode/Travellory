import 'package:pedantic/pedantic.dart';
import 'package:collection/collection.dart';

import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/NotifyListener.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/services/database/get_database.dart';

class SingleTripProvider {
  SingleTripProvider(TripModel trip, NotifyListener notifier){
    this.tripModel = trip;
    this.notifier = notifier;

    flights = <FlightModel>[];
    accommodations = <AccommodationModel>[];
    activities = <ActivityModel>[];
    rentalCars = <RentalCarModel>[];
    publicTransports = <PublicTransportModel>[];
  }

  final DatabaseGetter _databaseGetter = DatabaseGetter();
  final DatabaseAdder _databaseAdder = DatabaseAdder();
  final DatabaseDeleter _databaseDeleter = DatabaseDeleter();
  final DatabaseEditor _databaseEditor = DatabaseEditor();

  NotifyListener notifier;
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

  bool _bookingsInitiated = false;


  Future<void> initBookings() async {
    if(!_bookingsInitiated){
      unawaited(_fetchFlights());
      unawaited(_fetchAccommodation());
      unawaited(_fetchActivities());
      unawaited(_fetchPublicTransportation());
      unawaited(_fetchRentalCars());
      _bookingsInitiated = true;
    }
  }

  void _updateBookings(Model model, bool update) {
    if (update) {
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
  }

  Future<bool> addBooking(Model model, String functionName) async {
    final bool added = await _databaseAdder.addModel(model, functionName);
    _updateBookings(model, added);
    return added;
  }

    Future<bool> deleteModel(Model model, String functionName) async {
    final bool deleted = await _databaseDeleter.deleteModel(model, functionName);
    _updateBookings(model, deleted);
    return deleted;
  }

  Future<bool> editModel(Model model, String functionName) async {
    final bool edited = await _databaseEditor.editModel(model, functionName);
    _updateBookings(model, edited);
    return edited;
  }

  Future<void> _fetchFlights() async {
    isFetchingFlights = true;
    flights = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getFlights);
    isFetchingFlights = false;
    notifier.notify();
  }

  Future<void> _fetchAccommodation() async {
    isFetchingAccommodations = true;
    accommodations = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getAccommodations);
    isFetchingAccommodations = false;
    notifier.notify();
  }

  Future<void> _fetchActivities() async {
    isFetchingActivities = true;
    activities = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getActivities);
    isFetchingActivities = false;
    notifier.notify();
  }

  Future<void> _fetchRentalCars() async {
    isFetchingRentalCars = true;
    rentalCars = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getRentalCars);
    isFetchingRentalCars = false;
    notifier.notify();
  }

  Future<void> _fetchPublicTransportation() async {
    isFetchingPublicTransports = true;
    publicTransports = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getPublicTransportations);
    isFetchingPublicTransports = false;
    notifier.notify();
  }

  @override
  bool operator ==(o) {
    Function equals = const DeepCollectionEquality().equals;
    return o is SingleTripProvider
        && o.tripModel == tripModel
        && o.isFetching == isFetching
        && o.isFetchingFlights == isFetchingFlights
        && o.isFetchingActivities == isFetchingActivities
        && o.isFetchingAccommodations == isFetchingAccommodations
        && o.isFetchingRentalCars == isFetchingRentalCars
        && o.isFetchingPublicTransports == isFetchingPublicTransports
        && equals(o.flights, flights)
        && equals(o.rentalCars, rentalCars)
        && equals(o.publicTransports, publicTransports)
        && equals(o.activities, activities)
        && equals(o.accommodations, accommodations);
  }

}