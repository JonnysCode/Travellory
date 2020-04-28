import 'package:travellory/utils/date_converter.dart';

import 'abstract_model.dart';
import 'accommodation_model.dart';
import 'activity_model.dart';
import 'day_model.dart';
import 'flight_model.dart';
import 'public_transport_model.dart';
import 'rental_car_model.dart';


class TripModel extends Model {
  TripModel({
    this.userUID,
    this.uid,
    this.name,
    this.startDate,
    this.endDate,
    this.destination,
    this.imageNr,
    this.index
  });

  TripModel.fromData(trip) {
    userUID = trip["userUID"];
    uid = trip["uid"];
    name = trip["name"];
    startDate = trip["startDate"];
    endDate = trip["endDate"];
    destination = trip["destination"];
    imageNr = trip["imageNr"];
    imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
  }

  String userUID;
  String uid;
  String name;
  String startDate;
  String endDate;
  String destination;
  String imagePath;
  int imageNr;
  int index;
  List<Day> days;

  List<FlightModel> flights;
  List<AccommodationModel> accommodations;
  List<ActivityModel> activities;
  List<RentalCarModel> rentalCars;
  List<PublicTransportModel> publicTransports;

  void init(){
    _initImagePath();
    _initDays();
    flights = <FlightModel>[];
    accommodations = <AccommodationModel>[];
    activities = <ActivityModel>[];
    rentalCars = <RentalCarModel>[];
    publicTransports = <PublicTransportModel>[];
  }

  void _initImagePath(){
    imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
  }

  void _initDays() {
    days = <Day>[];
    var dateTime = getDateTimeFrom(startDate);
    var endDateTime = getDateTimeFrom(endDate);

    do {
      days.add(Day(
          date: dateTime
      ));
      dateTime = dateTime.add(Duration(days: 1));
    } while (dateTime.compareTo(endDateTime) <= 0);
  }

  @override
  Map<String, dynamic> toMap() {
    return {
        "userUID": userUID,
        "name": name,
        "startDate": startDate,
        "endDate": endDate,
        "destination": destination,
        "imageNr": imageNr
    };
  }
}

List<TripModel> tripModels = <TripModel>[];
