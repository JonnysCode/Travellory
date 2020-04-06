class FlightModel {
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

  Map<String, dynamic> toMap(){
    return {
      'bookingReference': bookingReference,
      'airline': airline,
      'flightNr': flightNr,
      'seat': seat,
      'departureLocation': departureLocation,
      'departureDate': departureDate,
      'departureTime': departureTime,
      'arrivalLocation': arrivalLocation,
      'arrivalDate': arrivalDate,
      'arrivalTime': arrivalTime,
      'checkedBaggage': checkedBaggage,
      'excessBaggage': excessBaggage,
      'notes': notes
    };
  }
}
