import 'package:travellory/models/abstract_model.dart';

class AccommodationModel extends Model {
  AccommodationModel(
      {this.type,
      this.hotelName,
      this.confirmationNr,
      this.address,
      this.nights,
      this.checkinDate,
      this.checkinTime,
      this.checkoutDate,
      this.checkoutTime,
      this.breakfast,
      this.roomType,
      this.accommodationType,
      this.notes});

  String type;
  String hotelName;
  String confirmationNr;
  String address;
  String nights;
  String checkinDate;
  String checkinTime;
  String checkoutDate;
  String checkoutTime;
  bool breakfast;
  String roomType;
  String accommodationType;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'hotelName': hotelName,
      'confirmationNr': confirmationNr,
      'address': address,
      'nights': nights,
      'checkinDate': checkinDate,
      'checkinTime': checkinTime,
      'checkoutDate': checkoutDate,
      'checkoutTime': checkoutTime,
      'breakfast': breakfast,
      'roomType': roomType,
      'accommodationType': accommodationType,
      'notes': notes
    };
  }
}

List<AccommodationModel> accommodationModels = <AccommodationModel>[
  AccommodationModel(
    type: 'Hotel',
    hotelName: 'Carina',
    confirmationNr: 'Ra1574e',
    address: 'Zürcherstrasse 5',
    nights: '2',
    checkinDate: '2020-05-11',
    checkinTime: '12:00:00',
    checkoutDate: '2020-05-13',
    checkoutTime: '10:00',
    breakfast: true,
    roomType: 'Double',
    accommodationType: null,
    notes: 'Some Notes'
  ),
];
