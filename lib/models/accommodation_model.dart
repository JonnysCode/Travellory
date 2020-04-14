import 'package:travellory/models/abstract_model.dart';

class AccommodationModel extends Model {
  AccommodationModel(
      {this.type,
      this.specificationOther,
      this.name,
      this.confirmationNr,
      this.address,
      this.nights,
      this.checkinDate,
      this.checkinTime,
      this.checkoutDate,
      this.checkoutTime,
      this.breakfast,
      this.hotelRoomType,
      this.airbnbType,
      this.notes});

  String type;
  String specificationOther;
  String name;
  String confirmationNr;
  String address;
  String nights;
  String checkinDate;
  String checkinTime;
  String checkoutDate;
  String checkoutTime;
  bool breakfast;
  String hotelRoomType;
  String airbnbType;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'specificationOther': specificationOther,
      'name': name,
      'confirmationNr': confirmationNr,
      'address': address,
      'nights': nights,
      'checkinDate': checkinDate,
      'checkinTime': checkinTime,
      'checkoutDate': checkoutDate,
      'checkoutTime': checkoutTime,
      'breakfast': breakfast,
      'hotelRoomType': hotelRoomType,
      'airbnbType': airbnbType,
      'notes': notes
    };
  }
}

List<AccommodationModel> accommodationModels = <AccommodationModel>[
  AccommodationModel(
      type: 'Hotel',
      specificationOther: null,
      name: 'Carina',
      confirmationNr: 'Ra1574e',
      address: 'Zürcherstrasse 5',
      nights: '2',
      checkinDate: '2020-05-11',
      checkinTime: '12:00:00',
      checkoutDate: '2020-05-13',
      checkoutTime: '10:00',
      breakfast: true,
      hotelRoomType: 'Double',
      airbnbType: null,
      notes: 'Some Notes'),
];
