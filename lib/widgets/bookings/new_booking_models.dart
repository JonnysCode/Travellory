import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/bookings/edit.dart';

ModifyModelArguments passPublicTransportModel(TripModel tripModel) {
  final PublicTransportModel publicTransportModel = PublicTransportModel();
  if (tripModel != null) {
    publicTransportModel.tripUID = tripModel.uid;
  }
  return ModifyModelArguments(
      model: publicTransportModel, isNewModel: true);
}

ModifyModelArguments passAccommodationModel(TripModel tripModel) {
  final AccommodationModel accommodationModel = AccommodationModel();
  if (tripModel != null) {
    accommodationModel.tripUID = tripModel.uid;
  }
  return ModifyModelArguments(model: accommodationModel, isNewModel: true);
}

ModifyModelArguments passActivityModel(TripModel tripModel) {
  final ActivityModel activityModel = ActivityModel();
  if (tripModel != null) {
    activityModel.tripUID = tripModel.uid;
  }
  return ModifyModelArguments(model: activityModel, isNewModel: true);
}

ModifyModelArguments passFlightModel(TripModel tripModel) {
  final FlightModel flightModel = FlightModel();
  if (tripModel != null) {
    flightModel.tripUID = tripModel.uid;
  }
  return ModifyModelArguments(model: flightModel, isNewModel: true);
}

ModifyModelArguments passRentalCarModel(TripModel tripModel) {
  final RentalCarModel rentalCarModel = RentalCarModel();
  if (tripModel != null) {
    rentalCarModel.tripUID = tripModel.uid;
  }
  return ModifyModelArguments(model: rentalCarModel, isNewModel: true);
}