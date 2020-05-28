import 'package:travellory/src/models/abstract_model.dart';

class RentalCarModel extends Model {
  RentalCarModel(
      {this.tripUID = '',
      this.uid = '',
      this.bookingReference = '',
      this.company = '',
      this.pickupLocation = '',
      this.pickupLatitude = 0.0,
      this.pickupLongitude = 0.0,
      this.pickupDate = '',
      this.pickupTime = '',
      this.returnLocation = '',
      this.returnLatitude = 0.0,
      this.returnLongitude = 0.0,
      this.returnDate = '',
      this.returnTime = '',
      this.carDescription = '',
      this.carNumberPlate = '',
      this.notes = ''});

  RentalCarModel.fromData(rentalCar) {
    tripUID = rentalCar["tripUID"];
    uid = rentalCar["uid"];
    bookingReference = rentalCar["bookingReference"];
    company = rentalCar["company"];
    pickupLocation = rentalCar["pickupLocation"];
    pickupLatitude = rentalCar["pickupLatitude"];
    pickupLongitude = rentalCar["pickupLongitude"];
    pickupDate = rentalCar["pickupDate"];
    pickupTime = rentalCar["pickupTime"];
    returnLocation = rentalCar["returnLocation"];
    returnLatitude = rentalCar["returnLatitude"];
    returnLongitude = rentalCar["returnLongitude"];
    returnDate = rentalCar["returnDate"];
    returnTime = rentalCar["returnTime"];
    carDescription = rentalCar["carDescription"];
    carNumberPlate = rentalCar["carNumberPlate"];
    notes = rentalCar["notes"];
  }

  String tripUID;
  String uid;
  String bookingReference;
  String company;
  String pickupLocation;
  double pickupLatitude;
  double pickupLongitude;
  String pickupDate;
  String pickupTime;
  String returnLocation;
  double returnLatitude;
  double returnLongitude;
  String returnDate;
  String returnTime;
  String carDescription;
  String carNumberPlate;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
      "uid": uid,
      "bookingReference": bookingReference,
      "company": company,
      "pickupLocation": pickupLocation,
      "pickupLatitude": pickupLatitude,
      "pickupLongitude": pickupLongitude,
      "pickupDate": pickupDate,
      "pickupTime": pickupTime,
      "returnLocation": returnLocation,
      "returnLatitude": returnLatitude,
      "returnLongitude": returnLongitude,
      "returnDate": returnDate,
      "returnTime": returnTime,
      "carDescription": carDescription,
      "carNumberPlate": carNumberPlate,
      "notes": notes
    };
  }
}

List<RentalCarModel> rentalCarModels = <RentalCarModel>[];
