import 'package:travellory/utils/date_converter.dart';

import 'abstract_model.dart';
import 'day_model.dart';

class TripModel extends Model {
  TripModel({
    this.userUID = '',
    this.uid = '',
    this.name = '',
    this.startDate = '',
    this.endDate = '',
    this.destination = '',
    this.country = '',
    this.countryCode = '',
    this.continent = '',
    this.imageNr,
    this.index,
  });

  TripModel.fromData(trip) {
    userUID = trip["userUID"];
    uid = trip["uid"];
    name = trip["name"];
    startDate = trip["startDate"];
    endDate = trip["endDate"];
    destination = trip["destination"];
    country = trip["country"];
    countryCode = trip["countryCode"];
    continent = trip["continent"];
    imageNr = trip["imageNr"];
    imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
  }

  String userUID;
  String uid;
  String name;
  String startDate;
  String endDate;
  String destination;
  String country;
  String countryCode;
  String continent;
  String imagePath;
  int imageNr;
  int index;

  void init() {
    _initImagePath();
  }

  void _initImagePath() {
    imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "userUID": userUID,
      "uid": uid,
      "name": name,
      "startDate": startDate,
      "endDate": endDate,
      "destination": destination,
      "country": country,
      "countryCode": countryCode,
      "continent": continent,
      "imageNr": imageNr
    };
  }
}
