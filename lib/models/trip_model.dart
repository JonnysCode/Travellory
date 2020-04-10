import 'abstract_model.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/utils/date_converter.dart';

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

  void init(){
    _initImagePath();
    _initDays();
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

  TripModel.fromData(trip) {
    this.userUID = trip["userUID"];
    this.name = trip["name"];
    this.startDate = trip["startDate"];
    this.endDate = trip["endDate"];
    this.destination = trip["destination"];
    this.imageNr = trip["imageNr"];
    this.imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
  }
}

List<TripModel> tripModels = <TripModel>[];
