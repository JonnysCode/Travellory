import 'package:travellory/models/abstract_model.dart';

class RentalCarModel extends Model {
  RentalCarModel(
      {this.bookingReference,
      this.company,
      this.pickupLocation,
      this.pickupDate,
      this.pickupTime,
      this.returnLocation,
      this.returnDate,
      this.returnTime,
      this.carDescription,
      this.carNumberPlate,
      this.notes});

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
      'bookingReference': bookingReference,
      'company': company,
      'pickupLocation': pickupLocation,
      'pickupDate': pickupDate,
      'pickupTime': pickupTime,
      'returnLocation': returnLocation,
      'returnDate': returnDate,
      'returnTime': returnTime,
      'carDescription': carDescription,
      'carNumberPlate': carNumberPlate,
      'notes': notes
    };
  }
}

List<RentalCarModel> rentalCarModels = <RentalCarModel>[
  RentalCarModel(
    bookingReference: 'R1',
    company: 'Hertz',
    pickupLocation: 'London',
    pickupDate: '2020-05-01',
    pickupTime: '15:10:00',
    returnLocation: 'London',
    returnDate: '2020-05-04',
    returnTime: '17:00:00',
    carDescription: 'Audi',
    carNumberPlate: 'FAB123',
    notes: null,
  ),
];
