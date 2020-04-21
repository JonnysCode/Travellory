import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/utils/date_converter.dart';

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
    this.arrivalLocation = '',
    this.arrivalDate = '',
    this.arrivalTime = '',
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
    departureDate = getOnlyDate(publicTransport["departureDate"]);
    departureTime = publicTransport["departureTime"];
    arrivalLocation = publicTransport["arrivalLocation"];
    arrivalDate = getOnlyDate(publicTransport["arrivalDate"]);
    arrivalTime = publicTransport["arrivalTime"];
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
  String arrivalLocation;
  String arrivalDate;
  String arrivalTime;
  String notes;

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
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
      "arrivalLocation": arrivalLocation,
      "arrivalDate": arrivalDate,
      "arrivalTime": arrivalTime,
      "notes": notes
    };
  }
}

List<PublicTransportModel> publicTransportModels = <PublicTransportModel>[];
