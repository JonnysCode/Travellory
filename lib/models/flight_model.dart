import 'booking_model.dart';

class FlightModel extends Booking{
  final String bookingReference;
  final String airline;
  final String flightNr;
  final String seat;
  final String departureLocation;
  final String departureDate;
  final String departureTime;
  final String arrivalLocation;
  final String arrivalDate;
  final String arrivalTime;
  final bool checkedBaggage;
  final bool excessBaggage;
  final String notes;

  FlightModel(
      {this.bookingReference,
      this.airline,
      this.flightNr,
      this.seat,
      this.departureLocation,
      this.departureDate,
      this.departureTime,
      this.arrivalLocation,
      this.arrivalDate,
      this.arrivalTime,
      this.checkedBaggage,
      this.excessBaggage,
      this.notes}) : super();
}
