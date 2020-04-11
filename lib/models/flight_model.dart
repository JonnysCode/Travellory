import 'package:travellory/models/abstract_model.dart';

class FlightModel extends Model {
  FlightModel({
    this.bookingReference,
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
    this.notes
  });

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

List<FlightModel> flightModel = <FlightModel>[
  FlightModel(
      bookingReference: 'A1B',
      airline: 'Swiss',
      flightNr: 'LX300',
      seat: '13F',
      departureLocation: 'ZRH',
      departureDate: '2020-05-01',
      departureTime: '15:07:00',
      arrivalLocation: 'LDN',
      arrivalDate: '2020-05-01',
      arrivalTime: '17:15:00',
      checkedBaggage: true,
      excessBaggage: false,
      notes: '',
  ),
];