class RentalCarModel {
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

  Map<String, dynamic> toMap(){
    return {
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