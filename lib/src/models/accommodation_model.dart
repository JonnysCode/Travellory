import 'package:travellory/src/models/abstract_model.dart';

class AccommodationModel extends Model {
  AccommodationModel({this.tripUID = '',
  this.uid = '',
  this.type = '',
  this.specificationOther = '',
  this.name = '',
  this.confirmationNr = '',
  this.address = '',
  this.nights = '',
  this.checkinDate = '',
  this.checkinTime = '',
  this.checkoutDate = '',
  this.checkoutTime = '',
  this.breakfast = false,
  this.hotelRoomType = '',
  this.airbnbType = '',
  this.notes = '',
  this.latitude = 0.0,
  this.longitude = 0.0});

  AccommodationModel.fromData(accommodation) {
    tripUID = accommodation["tripUID"];
    uid = accommodation["uid"];
    type = accommodation["type"];
    specificationOther = accommodation["specificationOther"];
    name = accommodation["name"];
    confirmationNr = accommodation["confirmationNr"];
    address = accommodation["address"];
    nights = accommodation["nights"];
    checkinDate = accommodation["checkinDate"];
    checkinTime = accommodation["checkinTime"];
    checkoutDate = accommodation["checkoutDate"];
    checkoutTime = accommodation["checkoutTime"];
    breakfast = accommodation["breakfast"];
    hotelRoomType = accommodation["hotelRoomType"];
    airbnbType = accommodation["airbnbType"];
    notes = accommodation["notes"];
    latitude = accommodation["latitude"];
    longitude = accommodation["longitude"];
  }

  String tripUID;
  String uid;
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
  double latitude;
  double longitude;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
      "uid": uid,
      "type": type,
      "specificationOther": specificationOther,
      "name": name,
      "confirmationNr": confirmationNr,
      "address": address,
      "nights": nights,
      "checkinDate": checkinDate,
      "checkinTime": checkinTime,
      "checkoutDate": checkoutDate,
      "checkoutTime": checkoutTime,
      "breakfast": breakfast,
      "hotelRoomType": hotelRoomType,
      "airbnbType": airbnbType,
      "notes": notes,
      "latitude": latitude,
      "longitude": longitude
    };
  }
}

List<AccommodationModel> accommodationModels = <AccommodationModel>[];
