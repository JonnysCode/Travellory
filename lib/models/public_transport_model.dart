import 'package:travellory/models/abstract_model.dart';

class PublicTransportModel extends Model {
  PublicTransportModel({
    this.transportationType,
    this.publicTransportCompany,
    this.specificType,
    this.booked,
    this.seatReserved,
    this.referenceNr,
    this.reservationCompany,
    this.seat,
    this.departureLocation,
    this.departureDate,
    this.departureTime,
    this.arrivalLocation,
    this.arrivalDate,
    this.arrivalTime,
    this.notes,
  });

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
      'transportationType': transportationType,
      'publicTransportCompany': publicTransportCompany,
      'specificType': specificType,
      'booked': booked,
      'seatReserved': seatReserved,
      'referenceNr': referenceNr,
      'reservationCompany': reservationCompany,
      'seat': seat,
      'departureLocation': departureLocation,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'arrivalLocation': arrivalLocation,
      'arrivalDate': arrivalDate,
      'arrivalTime': arrivalTime,
      'notes': notes
    };
  }
}

List<PublicTransportModel> publicTransportModels = <PublicTransportModel> [
  PublicTransportModel(
    transportationType: 'Rail',
    publicTransportCompany: 'RENFE',
    specificType: null,
    booked: true,
    seatReserved: true,
    referenceNr: 'R1A6',
    reservationCompany: 'RENFE',
    seat: '13F',
    departureLocation: 'Madrid',
    departureDate: '2020-06-20',
    departureTime: '12:00:00',
    arrivalLocation: 'Sevilla',
    arrivalDate: '2020-06-20',
    arrivalTime: '15:23:00',
    notes: 'Coche 8',
  ),
  PublicTransportModel(
    transportationType: 'Other',
    publicTransportCompany: 'RENFE',
    specificType: 'Cercanias',
    booked: true,
    seatReserved: false,
    referenceNr: 'R1A6',
    reservationCompany: 'RENFE',
    seat: '13F',
    departureLocation: 'Madrid',
    departureDate: '2020-06-20',
    departureTime: '12:00:00',
    arrivalLocation: 'Sevilla',
    arrivalDate: '2020-06-20',
    arrivalTime: '15:23:00',
    notes: 'Coche 8',
  )
];

