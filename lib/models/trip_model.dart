
import 'package:travellory/models/day_model.dart';

class TripModel {
  TripModel({
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

  String name;
  String startDate;
  String endDate;
  String destination;
  String imagePath;
  int imageNr;
  int index;
  List<Day> days;

  void _initDays() {
    var dateTime = _getDateTimeFrom(startDate);
    var endDateTime = _getDateTimeFrom(endDate);

    do{
      days.add(Day(
        date: dateTime
      ));
    } while(dateTime.add(Duration(days: 1)).isBefore(endDateTime));
    days.add(Day(
        date: endDateTime
    ));
  }
  
  DateTime _getDateTimeFrom(String date){
    List<String> dates = startDate.split('-');
    return DateTime(int.parse(dates[0]));
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