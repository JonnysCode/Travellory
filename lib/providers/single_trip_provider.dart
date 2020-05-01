import 'package:pedantic/pedantic.dart';
import 'package:collection/collection.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/NotifyListener.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/services/database/get_database.dart';
import 'package:travellory/utils/date_converter.dart';

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

  List<Day> days;

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

  // Fetches booking parallel and waits for them to finish
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

  Future<bool> addBooking(Model model, String functionName) async {
    final bool added = await _databaseAdder.addModel(model, functionName);
    if(added) {
      _updateBookings(model);
    }
    return added;
  }

    Future<bool> deleteModel(Model model, String functionName) async {
    final bool deleted = await _databaseDeleter.deleteModel(model, functionName);
    if(deleted) {
      _updateBookings(model);
    }
    return deleted;
  }

  Future<bool> editModel(Model model, String functionName) async {
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

  void _initDays() {
    days = <Day>[];
    var dateTime = getDateTimeFrom(tripModel.startDate);
    var endDateTime = getDateTimeFrom(tripModel.endDate);

    do {
      days.add(Day(
          date: dateTime
      ));
      dateTime = dateTime.add(Duration(days: 1));
    } while (dateTime.compareTo(endDateTime) <= 0);
  }

  void _addBookingToDays(){
    for(var day in days){
      flights.forEach((flight) {
        var startDate = getDateTimeFrom(flight.departureDate);
        var endDate = getDateTimeFrom(flight.arrivalDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.bookings.add(flight);
        }
      });
      rentalCars.forEach((rentalCar) {
        var startDate = getDateTimeFrom(rentalCar.pickupDate);
        var endDate = getDateTimeFrom(rentalCar.returnDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.bookings.add(rentalCar);
        }
      });
      publicTransports.forEach((publicTransport) {
        var startDate = getDateTimeFrom(publicTransport.departureDate);
        var endDate = getDateTimeFrom(publicTransport.arrivalDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.bookings.add(publicTransport);
        }
      });
      accommodations.forEach((accommodation){
        var startDate = getDateTimeFrom(accommodation.checkinDate);
        var endDate = getDateTimeFrom(accommodation.checkoutDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.bookings.add(accommodation);
        }
      });
      activities.forEach((activity){
        var startDate = getDateTimeFrom(activity.startDate);
        var endDate = getDateTimeFrom(activity.endDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.bookings.add(activity);
        }
      });
    }
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
        && equals(o.days, days)
        && equals(o.flights, flights)
        && equals(o.rentalCars, rentalCars)
        && equals(o.publicTransports, publicTransports)
        && equals(o.activities, activities)
        && equals(o.accommodations, accommodations);
  }

}