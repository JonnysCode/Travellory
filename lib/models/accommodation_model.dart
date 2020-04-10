import 'package:travellory/models/abstract_model.dart';

class AccommodationModel extends Model{

  String type;
  String hotelName;
  String confirmationNr;
  String address;
  String nights;
  String checkinDate;
  String checkinTime;
  String checkoutDate;
  String checkoutTime;
  bool breakfast;
  String roomType;
  String accommodationType;
  String notes;

  @override
  Map<String, dynamic> toMap(){
    return {
      'type': type,
      'hotelName': hotelName,
      'confirmationNr': confirmationNr,
      'address': address,
      'nights': nights,
      'checkinDate': checkinDate,
      'checkinTime': checkinTime,
      'checkoutDate': checkoutDate,
      'checkoutTime': checkoutTime,
      'breakfast': breakfast,
      'roomType': roomType,
      'accommodationType': accommodationType,
      'notes': notes
    };
  }
}