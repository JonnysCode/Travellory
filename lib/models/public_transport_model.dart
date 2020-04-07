import 'package:travellory/models/abstract_model.dart';

class PublicTransportModel extends Model {
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

  Map<String, dynamic> toMap(){
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