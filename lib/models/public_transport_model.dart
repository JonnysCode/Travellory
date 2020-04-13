import 'package:travellory/models/abstract_model.dart';

class PublicTransportModel extends Model {
  PublicTransportModel({
    this.transportationType,
    this.company,
    this.specificType,
    this.booked,
    this.seatReservation,
    this.reference,
    this.companyReservation,
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
  String company;
  String specificType;
  bool booked;
  bool seatReservation;
  String reference;
  String companyReservation;
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
      'company': company,
      'specificType': specificType,
      'booked': booked,
      'seatReservation': seatReservation,
      'reference': reference,
      'companyReservation': companyReservation,
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
    company: 'RENFE',
    specificType: null,
    booked: true,
    seatReservation: true,
    reference: 'R1A6',
    companyReservation: 'RENFE',
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

