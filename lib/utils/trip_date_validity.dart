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

bool tripDateIsValid(String value, String labelText, BuildContext context) {
  final SingleTripProvider singleTripProvider =
      Provider.of<TripsProvider>(context, listen: false).selectedTrip;

  bool tripIsValidDate;
  final DateTime tripDate = DateFormat("dd-MM-yyyy", "en_US").parse(value);
  bool accommodationIsValidated = false;
  List<AccommodationModel> tripAccommodations = singleTripProvider.accommodations;
  List<ActivityModel> tripActivities = singleTripProvider.activities;
  List<RentalCarModel> tripRentalCars = singleTripProvider.rentalCars;
  List<FlightModel> tripFlights = singleTripProvider.flights;
  List<PublicTransportModel> tripPublicTransports = singleTripProvider.publicTransports;

  bool activityIsValidated;
  bool rentalCarIsValidated;
  bool flightIsValidated;
  bool publicTransportIsValidated;

  if (labelText == 'Start Date *') {
    accommodationIsValidated = checkStartDateAccommodations(tripDate, tripAccommodations);
    activityIsValidated = checkStartDateActivities(tripDate, tripActivities);
    rentalCarIsValidated = checkPickUpDateRentalCars(tripDate, tripRentalCars);
    flightIsValidated = checkDepDateFlights(tripDate, tripFlights);
    publicTransportIsValidated = checkDepDatePublicTransports(tripDate, tripPublicTransports);
  }

  if (labelText == 'End Date *') {
    accommodationIsValidated = checkEndDateAccommodations(tripDate, tripAccommodations);
    activityIsValidated = checkEndDateActivities(tripDate, tripActivities);
    rentalCarIsValidated = checkReturnDateRentalCars(tripDate, tripRentalCars);
    flightIsValidated = checkArrDateFlights(tripDate, tripFlights);
    publicTransportIsValidated = checkArrDatePublicTransports(tripDate, tripPublicTransports);
  }

  if (accommodationIsValidated
      && activityIsValidated &&
      rentalCarIsValidated &&
      flightIsValidated &&
      publicTransportIsValidated
      ) {
    tripIsValidDate = true;
  } else {
    tripIsValidDate = false;
  }

  return tripIsValidDate;
}

bool checkStartDateAccommodations(DateTime tripDate, List<AccommodationModel> tripAccommodations) {
  bool isValid = true;

  if (tripAccommodations.isNotEmpty) {
    for (AccommodationModel model in tripAccommodations) {
      if (model.checkinDate != '' && model.checkinDate != null) {
        final DateTime checkinDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkinDate);
        if (tripDate.isAfter(checkinDate) && tripDate != checkinDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkEndDateAccommodations(DateTime tripDate, List<AccommodationModel> tripAccommodations) {
  bool isValid = true;

  if (tripAccommodations.isNotEmpty) {
    for (AccommodationModel model in tripAccommodations) {
      if (model.checkoutDate != '' && model.checkoutDate != null) {
        final DateTime checkoutDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkoutDate);
        if (tripDate.isBefore(checkoutDate) && tripDate != checkoutDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkStartDateActivities(DateTime tripDate, List<ActivityModel> tripActivities) {
  bool isValid = true;

  if (tripActivities.isNotEmpty) {
    for (ActivityModel model in tripActivities) {
      if (model.startDate != '' && model.startDate != null) {
        final DateTime startDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.startDate);
        if (tripDate.isAfter(startDate) && tripDate != startDate) {
          return false;
        }
      }
    }
  }
  return isValid;
}

bool checkEndDateActivities(DateTime tripDate, List<ActivityModel> tripActivities) {
  bool isValid = true;

  if (tripActivities.isNotEmpty) {
    for (ActivityModel model in tripActivities) {
      if (model.endDate != '' && model.endDate != null) {
        final DateTime endDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.endDate);
        if (tripDate.isBefore(endDate) && tripDate != endDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkPickUpDateRentalCars(DateTime tripDate, List<RentalCarModel> tripRentalCars) {
  bool isValid = true;

  if (tripRentalCars.isNotEmpty) {
    for (RentalCarModel model in tripRentalCars) {
      if (model.pickupDate != '' && model.pickupDate != null) {
        final DateTime pickupDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.pickupDate);
        if (tripDate.isAfter(pickupDate) && tripDate != pickupDate) {
          isValid = false;
        }
      }
      if (model.returnDate != '' && model.returnDate != null) {
        final DateTime returnDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.returnDate);
        if (tripDate.isBefore(returnDate) && tripDate != returnDate) {
          return true;
        }
      }
    }
  }
  return isValid;
}

bool checkReturnDateRentalCars(DateTime tripDate, List<RentalCarModel> tripRentalCars) {
  bool isValid = true;

  if (tripRentalCars.isNotEmpty) {
    for (RentalCarModel model in tripRentalCars) {
      if (model.returnDate != '' && model.returnDate != null) {
        final DateTime returnDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.returnDate);
        if (tripDate.isBefore(returnDate) && tripDate != returnDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkDepDateFlights(DateTime tripDate, List<FlightModel> tripFlights) {
  bool isValid = true;

  if (tripFlights.isNotEmpty) {
    for (FlightModel model in tripFlights) {
      if (model.departureDate != '' && model.departureDate != null) {
        final DateTime departureDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.departureDate);
        if (tripDate.isAfter(departureDate) && tripDate != departureDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkArrDateFlights(DateTime tripDate, List<FlightModel> tripFlights) {
  bool isValid = true;

  if (tripFlights.isNotEmpty) {
    for (FlightModel model in tripFlights) {
      if (model.arrivalDate != '' && model.arrivalDate != null) {
        final DateTime arrivalDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.arrivalDate);
        if (tripDate.isBefore(arrivalDate) && tripDate != arrivalDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkDepDatePublicTransports(
    DateTime tripDate, List<PublicTransportModel> tripPublicTransports) {
  bool isValid = true;

  if (tripPublicTransports.isNotEmpty) {
    for (PublicTransportModel model in tripPublicTransports) {
      if (model.departureDate != '' && model.departureDate != null) {
        final DateTime departureDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.departureDate);
        if (tripDate.isAfter(departureDate) && tripDate != departureDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkArrDatePublicTransports(
    DateTime tripDate, List<PublicTransportModel> tripPublicTransports) {
  bool isValid = true;

  if (tripPublicTransports.isNotEmpty) {
    for (PublicTransportModel model in tripPublicTransports) {
      if (model.arrivalDate != '' && model.arrivalDate != null) {
        final DateTime arrivalDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.arrivalDate);
        if (tripDate.isBefore(arrivalDate) && tripDate != arrivalDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}
