import 'package:travellory/src/models/abstract_model.dart';

class FlightModel extends Model {
  FlightModel(
      {this.tripUID = '',
      this.uid = '',
      this.bookingReference = '',
      this.airline = '',
      this.flightNr = '',
      this.seat = '',
      this.departureLocation = '',
      this.departureDate = '',
      this.departureTime = '',
      this.arrivalLocation = '',
      this.arrivalDate = '',
      this.arrivalTime = '',
      this.checkedBaggage = false,
      this.excessBaggage = false,
      this.notes = ''});

  FlightModel.fromData(flight) {
    tripUID = flight["tripUID"];
    uid = flight["uid"];
    bookingReference = flight["bookingReference"];
    airline = flight["airline"];
    flightNr = flight["flightNr"];
    seat = flight["seat"];
    departureLocation = flight["departureLocation"];
    departureDate = flight["departureDate"];
    departureTime = flight["departureTime"];
    arrivalLocation = flight["arrivalLocation"];
    arrivalDate = flight["arrivalDate"];
    arrivalTime = flight["arrivalTime"];
    checkedBaggage = flight["checkedBaggage"];
    excessBaggage = flight["excessBaggage"];
    notes = flight["notes"];
  }

  String tripUID;
  String uid;
  String bookingReference;
  String airline;
  String flightNr;
  String seat;
  String departureLocation;
  String departureDate;
  String departureTime;
  String arrivalLocation;
  String arrivalDate;
  String arrivalTime;
  bool checkedBaggage;
  bool excessBaggage;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
      "uid": uid,
      "bookingReference": bookingReference,
      "airline": airline,
      "flightNr": flightNr,
      "seat": seat,
      "departureLocation": departureLocation,
      "departureDate": departureDate,
      "departureTime": departureTime,
      "arrivalLocation": arrivalLocation,
      "arrivalDate": arrivalDate,
      "arrivalTime": arrivalTime,
      "checkedBaggage": checkedBaggage,
      "excessBaggage": excessBaggage,
      "notes": notes
    };
  }
}

List<FlightModel> flightModels = <FlightModel>[];
