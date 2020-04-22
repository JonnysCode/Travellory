import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/utils/date_converter.dart';

class RentalCarModel extends Model {
  RentalCarModel(
      {this.tripUID = '',
      this.uid = '',
      this.bookingReference = '',
      this.company = '',
      this.pickupLocation = '',
      this.pickupDate = '',
      this.pickupTime = '',
      this.returnLocation = '',
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
    pickupDate = rentalCar["pickupDate"];
    pickupTime = rentalCar["pickupTime"];
    returnLocation = rentalCar["returnLocation"];
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
  String pickupDate;
  String pickupTime;
  String returnLocation;
  String returnDate;
  String returnTime;
  String carDescription;
  String carNumberPlate;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
      "bookingReference": bookingReference,
      "company": company,
      "pickupLocation": pickupLocation,
      "pickupDate": pickupDate,
      "pickupTime": pickupTime,
      "returnLocation": returnLocation,
      "returnDate": returnDate,
      "returnTime": returnTime,
      "carDescription": carDescription,
      "carNumberPlate": carNumberPlate,
      "notes": notes
    };
  }
}

List<RentalCarModel> rentalCarModels = <RentalCarModel>[];
