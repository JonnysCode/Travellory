import 'package:travellory/models/abstract_model.dart';

class PublicTransportModel extends Model {
  PublicTransportModel({
    this.tripUID = '',
    this.uid = '',
    this.transportationType = '',
    this.publicTransportCompany = '',
    this.specificType = '',
    this.booked = false,
    this.seatReserved = false,
    this.referenceNr = '',
    this.reservationCompany = '',
    this.seat = '',
    this.departureLocation = '',
    this.departureDate = '',
    this.departureTime = '',
    this.departureLatitude = 0.0,
    this.departureLongitude = 0.0,
    this.arrivalLocation = '',
    this.arrivalDate = '',
    this.arrivalTime = '',
    this.arrivalLatitude = 0.0,
    this.arrivalLongitude = 0.0,
    this.notes = '',
  });

  PublicTransportModel.fromData(publicTransport) {
    tripUID = publicTransport["tripUID"];
    uid = publicTransport["uid"];
    transportationType = publicTransport["transportationType"];
    publicTransportCompany = publicTransport["publicTransportCompany"];
    specificType = publicTransport["specificType"];
    booked = publicTransport["booked"];
    seatReserved = publicTransport["seatReserved"];
    referenceNr = publicTransport["referenceNr"];
    reservationCompany = publicTransport["reservationCompany"];
    seat = publicTransport["seat"];
    departureLocation = publicTransport["departureLocation"];
    departureDate = publicTransport["departureDate"];
    departureTime = publicTransport["departureTime"];
    departureLatitude = publicTransport["departureLatitude"];
    departureLongitude = publicTransport["departureLongitude"];
    arrivalLocation = publicTransport["arrivalLocation"];
    arrivalDate = publicTransport["arrivalDate"];
    arrivalTime = publicTransport["arrivalTime"];
    arrivalLatitude = publicTransport["arrivalLatitude"];
    arrivalLongitude = publicTransport["arrivalLongitude"];
    notes = publicTransport["notes"];
  }

  String tripUID;
  String uid;
  String transportationType;
  String publicTransportCompany;
  String specificType;
  bool booked;
  bool seatReserved;
  String referenceNr;
  String reservationCompany;
  String seat;
  String departureLocation;
  String departureDate;
  String departureTime;
  double departureLatitude;
  double departureLongitude;
  String arrivalLocation;
  String arrivalDate;
  String arrivalTime;
  double arrivalLatitude;
  double arrivalLongitude;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
      "uid": uid,
      "transportationType": transportationType,
      "publicTransportCompany": publicTransportCompany,
      "specificType": specificType,
      "booked": booked,
      "seatReserved": seatReserved,
      "referenceNr": referenceNr,
      "reservationCompany": reservationCompany,
      "seat": seat,
      "departureLocation": departureLocation,
      "departureDate": departureDate,
      "departureTime": departureTime,
      "departureLatitude": departureLatitude,
      "departureLongitude": departureLongitude,
      "arrivalLocation": arrivalLocation,
      "arrivalDate": arrivalDate,
      "arrivalTime": arrivalTime,
      "arrivalLatitude": arrivalLatitude,
      "arrivalLongitude": arrivalLongitude,
      "notes": notes
    };
  }
}

List<PublicTransportModel> publicTransportModels = <PublicTransportModel>[];
