import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';

class DatabaseDeleter {
  Future<bool> deleteModel(Model model, String correspondingFunctionName) async {

  }
}

// method to get database function names for delete function based on model
String getDeleteFunctionNameBasedOn(Model model) {
  String functionName;
  if (model is FlightModel) {
    functionName = 'delete-flight';
  } else if (model is RentalCarModel) {
    functionName = 'delete-rentalCar';
  } else if (model is AccommodationModel) {
    functionName = 'delete-accommodation';
  } else if (model is PublicTransportModel) {
    functionName = 'delete-publicTransport';
  } else if (model is ActivityModel) {
    functionName = 'delete-activity';
  } else {
    functionName = '';
  }
  return functionName;
}

void Function() onDeleteBooking() {
 // TODO (nadine): implement delete booking function maybe similar to onSubmitTrip ?
}
