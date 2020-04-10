import 'abstract_model.dart';

class TripModel extends Model {
  TripModel(
      {this.userUID,
      this.name,
      this.startDate,
      this.endDate,
      this.destination,
      this.imageNr,
      this.index}) {
    imagePath = 'assets/images/home/trip/trip_${imageNr.toString()}.png';
  }

  String userUID;
  String name;
  String startDate;
  String endDate;
  String destination;
  String imagePath;
  int imageNr;
  int index;

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
