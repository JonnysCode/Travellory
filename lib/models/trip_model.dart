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
  }){
    imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
    _initDays();
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

  void _initDays() {
    days = <Day>[];
    var dateTime = DateConverter.getDateTimeFrom(startDate);
    var endDateTime = DateConverter.getDateTimeFrom(endDate);

    do {
      days.add(Day(
          date: dateTime
      ));
      dateTime = dateTime.add(Duration(days: 1));
    } while (dateTime.compareTo(endDateTime) <= 0);
  }

  @override
  Map<String, dynamic> toMap(){
    return {
      'userUID': userUID,
      'name': name,
      'startDate': startDate,
      'endDate': endDate,
      'destination': destination,
      'imagePath': imagePath,
      'imageNr': imageNr,
      'index': index,
    };
  }
}

List<TripModel> tripModels = <TripModel>[
  TripModel(
    name: 'Castle Discovery',
    startDate: '2020-06-23',
    endDate: '2020-07-12',
    destination: 'Munich',
    imageNr: 3
  ),
  TripModel(
      name: 'Beach Relaxation',
      startDate: '2020-05-12',
      endDate: '2020-05-18',
      destination: 'Maledives',
      imageNr: 1
  ),
  TripModel(
      name: 'City Trip',
      startDate: '2020-08-09',
      endDate: '2020-08-21',
      destination: 'San Francisco',
      imageNr: 2
  ),
];