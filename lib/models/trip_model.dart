import 'package:travellory/models/day_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'abstract_model.dart';


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
    print(trip);
    userUID = trip["userUID"];
    uid = trip["uid"];
    name = trip["name"];
    startDate = getOnlyDate(trip["startDate"]);
    endDate = getOnlyDate(trip["endDate"]);
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

  String getOnlyDate(String date) {
    List<String> dateTime = date.split("T");
    return dateTime[0];
  }
}

List<TripModel> tripModels = <TripModel>[];
