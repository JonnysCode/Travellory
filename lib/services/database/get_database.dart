import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';

class DatabaseGetter{
  final String getTrips = 'trips-getTrips';
  final String getFlights = 'booking-getFlights';
  final String getAccommodations = 'booking-getAccommodations';
  final String getRentalCars = 'booking-getRentalCars';
  final String getPublicTransportations = 'booking-getPublicTransportations';
  final log = getLogger('DatabaseGetter');

  Future<List<Model>> getEntriesFromDatabase(String uid, String function) async {
    final HttpsCallable callable =
    CloudFunctions.instance.getHttpsCallable(functionName: function);
    List<dynamic> entries = [];
    try {
      final HttpsCallableResult result = await callable.call(_getMap(uid, function));
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
      case "trips-getTrips":
        return {"userUID": uid};
        break;
    }
    return {"tripUID": uid};
  }

  List<Model> _createEntries(dbEntries, function) {
    List<Model> entries = <Model>[];
    switch (function) {
      case "booking-getFlights":
        entries = _createFlights(dbEntries);
        break;
      case "booking-getAccommodations":
        entries = _createAccommodations(dbEntries);
        break;
      case "booking-getRentalCars":
        entries = _createRentalCars(dbEntries);
        break;
      case "booking-getPublicTransportations":
        entries = _createPublicTransports(dbEntries);
        break;
      case "trips-getTrips":
        entries = _createTrips(dbEntries);
        break;
    }
    return entries;
  }

  List<TripModel> _createTrips(dbTrips) {
    // add trips from DB to tripModels
    List<TripModel> trips = <TripModel>[];
    for (var dbTrip in dbTrips) {
      TripModel trip = TripModel.fromData(dbTrip);
      trips.add(trip);
    }
    return trips;
  }

  List<FlightModel> _createFlights(dbFlights) {
    // add flights from DB to flightModels
    List<FlightModel> flights = <FlightModel>[];
    for (var dbFlight in dbFlights) {
      FlightModel flight = FlightModel.fromData(dbFlight);
      flights.add(flight);
    }
    return flights;
  }

  List<AccommodationModel> _createAccommodations(dbAccommodations) {
    // add accommodations from DB to accommodationModels
    List<AccommodationModel> accommodations = <AccommodationModel>[];
    for (var dbAccommodation in dbAccommodations) {
      AccommodationModel accommodation = AccommodationModel.fromData(dbAccommodation);
      accommodations.add(accommodation);
    }
    return accommodations;
  }

  List<RentalCarModel> _createRentalCars(dbRentalCars) {
    // add rentalcars from DB to rentalcarModels
    List<RentalCarModel> rentalCars = <RentalCarModel>[];
    for (var dbRentalCar in dbRentalCars) {
      RentalCarModel rentalCar = RentalCarModel.fromData(dbRentalCar);
      rentalCars.add(rentalCar);
    }
    return rentalCars;
  }

  List<PublicTransportModel> _createPublicTransports(dbPublicTransports) {
    // add publictransport from DB to publictransportModels
    List<PublicTransportModel> publicTransports = <PublicTransportModel>[];
    for (var dbPublicTransport in dbPublicTransports) {
      PublicTransportModel publicTransport = PublicTransportModel.fromData(dbPublicTransport);
      publicTransports.add(publicTransport);
    }
    return publicTransports;
  }
}
