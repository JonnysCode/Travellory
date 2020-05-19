import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';

bool tripDateIsValid(String value, BuildContext context) {
  final SingleTripProvider singleTripProvider =
      Provider.of<TripsProvider>(context, listen: false).selectedTrip;

  bool tripIsValidDate;
  final DateTime tripDate = DateFormat("dd-MM-yyyy", "en_US").parse(value);

  bool accommodationIsValidated = checkAccommodations(tripDate, singleTripProvider);
  bool activityIsValidated = checkActivities(tripDate, singleTripProvider);
  bool rentalCarIsValidated = checkRentalCars(tripDate, singleTripProvider);
  bool flightIsValidated = checkFlights(tripDate, singleTripProvider);
  bool publicTransportIsValidated = checkPublicTransports(tripDate, singleTripProvider);

  if (accommodationIsValidated &&
      activityIsValidated &&
      rentalCarIsValidated &&
      flightIsValidated &&
      publicTransportIsValidated) {
    tripIsValidDate = true;
  } else {
    tripIsValidDate = false;
  }

  return tripIsValidDate;
}

bool checkAccommodations(DateTime tripDate, SingleTripProvider singleTripProvider) {
  List<AccommodationModel> tripAccommodations = singleTripProvider.accommodations;

  if (tripAccommodations.isNotEmpty) {
    for (AccommodationModel model in tripAccommodations) {
      if (model.checkinDate != '' && model.checkinDate != null) {
        final DateTime checkinDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkinDate);
        if (tripDate.isAfter(checkinDate) || tripDate != checkinDate) {
          return false;
        }
      }
      if (model.checkoutDate != '' && model.checkoutDate != null) {
        final DateTime checkoutDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkoutDate);
        if (tripDate.isBefore(checkoutDate) || tripDate != checkoutDate) {
          return false;
        }
      }
    }
  }
  return true;
}

bool checkActivities(DateTime tripDate, SingleTripProvider singleTripProvider) {
  List<ActivityModel> tripActivities = singleTripProvider.activities;

  if (tripActivities.isNotEmpty) {
    for (ActivityModel model in tripActivities) {
      if (model.startDate != '' && model.startDate != null) {
        final DateTime startDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.startDate);
        if (tripDate.isAfter(startDate) || tripDate != startDate) {
          return false;
        }
      }
      if (model.endDate != '' && model.endDate != null) {
        final DateTime endDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.endDate);
        if (tripDate.isBefore(endDate) || tripDate != endDate) {
          return false;
        }
      }
    }
  }
  return true;
}

bool checkRentalCars(DateTime tripDate, SingleTripProvider singleTripProvider) {
  List<RentalCarModel> tripRentalCars = singleTripProvider.rentalCars;

  if (tripRentalCars.isNotEmpty) {
    for (RentalCarModel model in tripRentalCars) {
      if (model.pickupDate != '' && model.pickupDate != null) {
        final DateTime pickupDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.pickupDate);
        if (tripDate.isAfter(pickupDate) || tripDate != pickupDate) {
          return false;
        }
      }
      if (model.returnDate != '' && model.returnDate != null) {
        final DateTime returnDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.returnDate);
        if (tripDate.isBefore(returnDate) || tripDate != returnDate) {
          return false;
        }
      }
    }
  }
  return true;
}

bool checkFlights(DateTime tripDate, SingleTripProvider singleTripProvider) {
  List<FlightModel> tripFlights = singleTripProvider.flights;

  if (tripFlights.isNotEmpty) {
    for (FlightModel model in tripFlights) {
      if (model.departureDate != '' && model.departureDate != null) {
        final DateTime departureDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.departureDate);
        if (tripDate.isAfter(departureDate) || tripDate != departureDate) {
          return false;
        }
      }
      if (model.arrivalDate != '' && model.arrivalDate != null) {
        final DateTime arrivalDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.arrivalDate);
        if (tripDate.isBefore(arrivalDate) || tripDate != arrivalDate) {
          return false;
        }
      }
    }
  }
  return true;
}

bool checkPublicTransports(DateTime tripDate, SingleTripProvider singleTripProvider) {
  List<PublicTransportModel> tripPublicTransports = singleTripProvider.publicTransports;

  if (tripPublicTransports.isNotEmpty) {
    for (PublicTransportModel model in tripPublicTransports) {
      if (model.departureDate != '' && model.departureDate != null) {
        final DateTime departureDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.departureDate);
        if (tripDate.isAfter(departureDate) || tripDate != departureDate) {
          return false;
        }
      }
      if (model.arrivalDate != '' && model.arrivalDate != null) {
        final DateTime arrivalDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.arrivalDate);
        if (tripDate.isBefore(arrivalDate) || tripDate != arrivalDate) {
          return false;
        }
      }
    }
  }
  return true;
}
