class FlightModel {
  final String bookingReference;
  final String airline;
  final String flightNr;
  final String seat;
  final String departureLocation;
  final String departureTime;
  final String arrivalLocation;
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
      this.departureTime,
      this.arrivalLocation,
      this.arrivalTime,
      this.checkedBaggage,
      this.excessBaggage,
      this.notes});
}