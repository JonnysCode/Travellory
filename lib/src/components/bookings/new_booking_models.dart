import 'package:travellory/src/models/abstract_model.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/trip_model.dart';

class ModifyModelArguments {
  ModifyModelArguments({this.model, this.isNewModel});

  final Model model;
  final bool isNewModel;
}

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