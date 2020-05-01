import 'package:travellory/models/abstract_model.dart';
import "package:google_maps_webservice/places.dart";
import 'package:travellory/services/api/map/locations.dart';
import 'package:travellory/utils/date_converter.dart';

const double lat = 0.0;
const double lng = 0.0;

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
  // ignore: avoid_init_to_null
  this.location = null});

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
    location = accommodation["location"];
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
  Location location;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
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
      "location": location
    };
  }
}

List<AccommodationModel> accommodationModels = <AccommodationModel>[];
