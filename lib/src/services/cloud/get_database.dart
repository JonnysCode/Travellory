import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/src/models/abstract_model.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/components/shared/logger.dart';

class DatabaseGetter {
  factory DatabaseGetter() {
    return _instance;
  }

  DatabaseGetter._privateConstructor();

  static final DatabaseGetter _instance = DatabaseGetter._privateConstructor();

  static const String getTrips = 'trips-getTrips';
  static const String getFlights = 'flight-getFlights';
  static const String getAccommodations = 'accommodation-getAccommodations';
  static const String getActivities = 'activity-getActivities';
  static const String getRentalCars = 'rentalcar-getRentalCars';
  static const String getPublicTransportation = 'publictransportation-getPublicTransportations';
  static const String getTempAccommodations = 'accommodation-getTempAccommodations';

  static const String _emptyResult = 'no-data';
  static const int _maxCount = 200;

  static int _count = 0;

  final log = getLogger('DatabaseGetter');

  Future<List<Model>> getEntriesFromDatabase(String uid, String function) async {
    if (_count++ >= _maxCount) {
      log.w('maxCount exceeded in get');
      return <Model>[];
    }

    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(functionName: function);
    List<dynamic> entries = [];
    try {
      log.d('JSON data for function call $function: ${_getMap(uid, function)}');
      final HttpsCallableResult result = await callable.call(_getMap(uid, function));
      if (result.data.contains(_emptyResult)) {
        return _getEmptyEntries(function);
      }
      entries = result.data;
    } on CloudFunctionsException catch (e) {
      log.e('caught firebase functions exception');
      log.e(e.code);
      log.e(e.message);
      log.e(e.details);
    } on Exception catch (e) {
      log.w('caught generic exception');
      log.w(e);
    }
    return _createEntries(entries, function);
  }

  Map<String, dynamic> _getMap(String uid, String function) {
    switch (function) {
      case getTrips:
      case getTempAccommodations:
        return {"userUID": uid};
        break;
    }
    return {"tripUID": uid};
  }

  List<Model> _getEmptyEntries(function) {
    List<Model> entries = <Model>[];
    switch (function) {
      case getFlights:
        entries = <FlightModel>[];
        break;
      case getAccommodations:
        entries = <AccommodationModel>[];
        break;
      case getRentalCars:
        entries = <RentalCarModel>[];
        break;
      case getPublicTransportation:
        entries = <PublicTransportModel>[];
        break;
      case getActivities:
        entries = <ActivityModel>[];
        break;
      case getTrips:
        entries = <TripModel>[];
        break;
      case getTempAccommodations:
        entries = <AccommodationModel>[];
        break;
    }
    return entries;
  }

  List<Model> _createEntries(dbEntries, function) {
    List<Model> entries = <Model>[];
    switch (function) {
      case getFlights:
        entries = _createFlights(dbEntries);
        break;
      case getAccommodations:
        entries = _createAccommodations(dbEntries);
        break;
      case getRentalCars:
        entries = _createRentalCars(dbEntries);
        break;
      case getPublicTransportation:
        entries = _createPublicTransports(dbEntries);
        break;
      case getActivities:
        entries = _createActivities(dbEntries);
        break;
      case getTrips:
        entries = _createTrips(dbEntries);
        break;
      case getTempAccommodations:
        entries = _createAccommodations(dbEntries);
        break;
    }
    return entries;
  }

  List<TripModel> _createTrips(dbTrips) {
    // add trips from DB to tripModels
    final List<TripModel> trips = <TripModel>[];
    for (final dbTrip in dbTrips) {
      final TripModel trip = TripModel.fromData(dbTrip);
      trips.add(trip);
    }
    return trips;
  }

  List<FlightModel> _createFlights(dbFlights) {
    // add flights from DB to flightModels
    final List<FlightModel> flights = <FlightModel>[];
    for (final dbFlight in dbFlights) {
      final FlightModel flight = FlightModel.fromData(dbFlight);
      flights.add(flight);
    }
    return flights;
  }

  List<AccommodationModel> _createAccommodations(dbAccommodations) {
    // add accommodations from DB to accommodationModels
    final List<AccommodationModel> accommodations = <AccommodationModel>[];
    for (final dbAccommodation in dbAccommodations) {
      final AccommodationModel accommodation = AccommodationModel.fromData(dbAccommodation);
      accommodations.add(accommodation);
    }
    return accommodations;
  }

  List<RentalCarModel> _createRentalCars(dbRentalCars) {
    // add rentalcars from DB to rentalcarModels
    final List<RentalCarModel> rentalCars = <RentalCarModel>[];
    for (final dbRentalCar in dbRentalCars) {
      final RentalCarModel rentalCar = RentalCarModel.fromData(dbRentalCar);
      rentalCars.add(rentalCar);
    }
    return rentalCars;
  }

  List<PublicTransportModel> _createPublicTransports(dbPublicTransports) {
    // add publictransport from DB to publictransportModels
    final List<PublicTransportModel> publicTransports = <PublicTransportModel>[];
    for (final dbPublicTransport in dbPublicTransports) {
      final PublicTransportModel publicTransport = PublicTransportModel.fromData(dbPublicTransport);
      publicTransports.add(publicTransport);
    }
    return publicTransports;
  }

  List<ActivityModel> _createActivities(dbActivities) {
    // add activity from DB to activityModels
    final List<ActivityModel> activities = <ActivityModel>[];
    for (final dbActivity in dbActivities) {
      final ActivityModel activity = ActivityModel.fromData(dbActivity);
      activities.add(activity);
    }
    return activities;
  }
}
