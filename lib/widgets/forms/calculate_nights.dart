import 'package:intl/intl.dart';
import 'package:travellory/models/accommodation_model.dart';

/// calculates the nights from checkin to checkout date
AccommodationModel calculateNightsForAccommodation(AccommodationModel model) {
  if (model.checkinDate != '' &&
      model.checkinDate != null &&
      model.checkoutDate != '' &&
      model.checkoutDate != null) {
    DateTime firstDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkinDate);
    DateTime secondDate = DateFormat("dd-MM-yyyy", "en_US").parse(model.checkoutDate);
    String nights = secondDate.difference(firstDate).inDays.toString();
    model.nights = nights;
  }
  return model;
}
