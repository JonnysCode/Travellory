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

/// validates if trip edit date is still in range of all bookings
/// if booking already have added to the trip, then this will verify if the
/// trip start date is not set after any of the bookings start and the
/// trip end date is not set before any of the bookings end
///
/// Returns true if both cases are valid
bool tripDateIsValid(String value, String labelText, BuildContext context) {
  final SingleTripProvider singleTripProvider =
      Provider.of<TripsProvider>(context, listen: false).selectedTrip;
  final DateTime tripDate = DateFormat("dd-MM-yyyy", "en_US").parse(value);

  bool tripIsValidDate = false;

  if (labelText == 'Start Date *') {
    tripIsValidDate = checkStartTrip(tripDate, singleTripProvider);
  }

  if (labelText == 'End Date *') {
    tripIsValidDate = checkEndTrip(tripDate, singleTripProvider);
  }

  return tripIsValidDate;
}

/// Returns true if all booking dates begin on or after the new start trip date
bool checkStartTrip(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final bool accommodationIsValidated = checkStartDateAccommodations(tripDate, singleTripProvider);
  final bool activityIsValidated = checkStartDateActivities(tripDate, singleTripProvider);
  final bool rentalCarIsValidated = checkPickUpDateRentalCars(tripDate, singleTripProvider);
  final bool flightIsValidated = checkDepDateFlights(tripDate, singleTripProvider);
  final bool publicTransportIsValidated = checkDepDatePublicTransports(tripDate, singleTripProvider);

  if (accommodationIsValidated &&
      activityIsValidated &&
      rentalCarIsValidated &&
      flightIsValidated &&
      publicTransportIsValidated) {
    return true;
  }
  return false;
}

/// Returns true if all booking dates end on or before the new end trip date
bool checkEndTrip(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final bool accommodationIsValidated = checkEndDateAccommodations(tripDate, singleTripProvider);
  final bool activityIsValidated = checkEndDateActivities(tripDate, singleTripProvider);
  final bool rentalCarIsValidated = checkReturnDateRentalCars(tripDate, singleTripProvider);
  final bool flightIsValidated = checkArrDateFlights(tripDate, singleTripProvider);
  final bool publicTransportIsValidated = checkArrDatePublicTransports(tripDate, singleTripProvider);

  if (accommodationIsValidated &&
      activityIsValidated &&
      rentalCarIsValidated &&
      flightIsValidated &&
      publicTransportIsValidated) {
    return true;
  }
  return false;
}

bool checkStartDateAccommodations(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<AccommodationModel> tripAccommodations = singleTripProvider.accommodations;
  bool isValid = true;

  if (tripAccommodations.isNotEmpty) {
    for (final AccommodationModel model in tripAccommodations) {
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

bool checkEndDateAccommodations(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<AccommodationModel> tripAccommodations = singleTripProvider.accommodations;
  bool isValid = true;

  if (tripAccommodations.isNotEmpty) {
    for (final AccommodationModel model in tripAccommodations) {
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

bool checkStartDateActivities(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<ActivityModel> tripActivities = singleTripProvider.activities;
  bool isValid = true;

  if (tripActivities.isNotEmpty) {
    for (final ActivityModel model in tripActivities) {
      if (model.startDate != '' && model.startDate != null) {
        final DateTime startDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.startDate);
        if (tripDate.isAfter(startDate) && tripDate != startDate) {
          isValid = false;
        }
      }
    }
  }
  return isValid;
}

bool checkEndDateActivities(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<ActivityModel> tripActivities = singleTripProvider.activities;
  bool isValid = true;

  if (tripActivities.isNotEmpty) {
    for (final ActivityModel model in tripActivities) {
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

bool checkPickUpDateRentalCars(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<RentalCarModel> tripRentalCars = singleTripProvider.rentalCars;
  bool isValid = true;

  if (tripRentalCars.isNotEmpty) {
    for (final RentalCarModel model in tripRentalCars) {
      if (model.pickupDate != '' && model.pickupDate != null) {
        final DateTime pickupDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.pickupDate);
        if (tripDate.isAfter(pickupDate) && tripDate != pickupDate) {
          isValid = false;
        }
      }
      if (model.returnDate != '' && model.returnDate != null) {
        final DateTime returnDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.returnDate);
        if (tripDate.isBefore(returnDate) && tripDate != returnDate) {
          isValid = true;
        }
      }
    }
  }
  return isValid;
}

bool checkReturnDateRentalCars(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<RentalCarModel> tripRentalCars = singleTripProvider.rentalCars;
  bool isValid = true;

  if (tripRentalCars.isNotEmpty) {
    for (final RentalCarModel model in tripRentalCars) {
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

bool checkDepDateFlights(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<FlightModel> tripFlights = singleTripProvider.flights;
  bool isValid = true;

  if (tripFlights.isNotEmpty) {
    for (final FlightModel model in tripFlights) {
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

bool checkArrDateFlights(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<FlightModel> tripFlights = singleTripProvider.flights;
  bool isValid = true;

  if (tripFlights.isNotEmpty) {
    for (final FlightModel model in tripFlights) {
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

bool checkDepDatePublicTransports(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<PublicTransportModel> tripPublicTransports = singleTripProvider.publicTransports;
  bool isValid = true;

  if (tripPublicTransports.isNotEmpty) {
    for (final PublicTransportModel model in tripPublicTransports) {
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

bool checkArrDatePublicTransports(DateTime tripDate, SingleTripProvider singleTripProvider) {
  final List<PublicTransportModel> tripPublicTransports = singleTripProvider.publicTransports;
  bool isValid = true;

  if (tripPublicTransports.isNotEmpty) {
    for (final PublicTransportModel model in tripPublicTransports) {
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
