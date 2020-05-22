import 'package:pedantic/pedantic.dart';

import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/notify_listener.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/services/database/get_database.dart';

class SingleTripProvider {
  SingleTripProvider(TripModel trip, NotifyListener notifier){
    this.tripModel = trip;
    this._notifier = notifier;

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

  NotifyListener _notifier;
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

  /// Initiates all bookings for a trip.
  ///
  /// If the bookings are not yet initiated, fights,
  /// accommodations, activities, public transport
  /// and rental cars get fetched from the db.
  /// The [TripsProvider] gets notified after each
  /// successful fetch.
  Future<void> initBookings() async {
    if(!_bookingsInitiated){
      _bookingsInitiated = true;
      await Future.wait([
        _fetchFlights(),
        _fetchAccommodation(),
        _fetchActivities(),
        _fetchPublicTransportation(),
        _fetchRentalCars()
      ]);
    }
  }

  void _updateBookings(Model model) {
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

  /// Adds and fetches a booking from the db.
  Future<bool> addBooking(Model model, String functionName) async {
    final bool added = await _databaseAdder.addModel(model, functionName);
    if(added) {
      _updateBookings(model);
    }
    return added;
  }

  /// Deletes and fetches a booking from the db.
  Future<bool> deleteBooking(Model model, String functionName) async {
    final bool deleted = await _databaseDeleter.deleteModel(model, functionName);
    if(deleted) {
      _updateBookings(model);
    }
    return deleted;
  }

  /// Edits and fetches the bookings from the db.
  Future<bool> editBooking(Model model, String functionName) async {
    final bool edited = await _databaseEditor.editModel(model, functionName);
    if(edited) {
      _updateBookings(model);
    }
    return edited;
  }

  Future<void> _fetchFlights() async {
    isFetchingFlights = true;
    flights = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getFlights);
    isFetchingFlights = false;
    _notifier.notify();
  }

  Future<void> _fetchAccommodation() async {
    isFetchingAccommodations = true;
    accommodations = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getAccommodations);
    isFetchingAccommodations = false;
    _notifier.notify();
  }

  Future<void> _fetchActivities() async {
    isFetchingActivities = true;
    activities = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getActivities);
    isFetchingActivities = false;
    _notifier.notify();
  }

  Future<void> _fetchRentalCars() async {
    isFetchingRentalCars = true;
    rentalCars = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getRentalCars);
    isFetchingRentalCars = false;
    _notifier.notify();
  }

  Future<void> _fetchPublicTransportation() async {
    isFetchingPublicTransports = true;
    publicTransports = await _databaseGetter.getEntriesFromDatabase(
        tripModel.uid, DatabaseGetter.getPublicTransportations);
    isFetchingPublicTransports = false;
    _notifier.notify();
  }
}