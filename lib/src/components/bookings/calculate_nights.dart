import 'package:intl/intl.dart';
import 'package:travellory/src/models/accommodation_model.dart';

/// calculates the nights from checkin to checkout date
AccommodationModel calculateNightsForAccommodation(AccommodationModel model) {
  if (model.checkinDate != '' &&
      model.checkinDate != null &&
      model.checkoutDate != '' &&
      model.checkoutDate != null) {
    final DateTime firstDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkinDate);
    final DateTime secondDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkoutDate);
    final String nights = secondDate.difference(firstDate).inDays.toString();
    model.nights = nights;
  }
  return model;
}
