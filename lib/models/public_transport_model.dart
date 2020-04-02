class PublicTransportModel {
  PublicTransportModel(
      {this.transportationType,
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
        this.notes});

  final String transportationType;
  final String company;
  final String specificType;
  final bool booked;
  final bool seatReservation;
  final String reference;
  final String companyReservation;
  final String seat;
  final String departureLocation;
  final String departureDate;
  final String departureTime;
  final String arrivalLocation;
  final String arrivalDate;
  final String arrivalTime;
  final String notes;
}