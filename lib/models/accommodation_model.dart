class AccommodationModel {
  final String type;
  final String hotelName;
  final String confirmationNr;
  final String address;
  final String nights;
  final String checkinDate;
  final String checkinTime;
  final String checkoutDate;
  final String checkoutTime;
  final bool breakfast;
  final String roomType;
  final String accommodationType;
  final String notes;

  AccommodationModel(
      {this.type,
        this.hotelName,
        this.confirmationNr,
        this.address,
        this.nights,
        this.checkinDate,
        this.checkinTime,
        this.checkoutDate,
        this.checkoutTime,
        this.breakfast,
        this.roomType,
        this.accommodationType,
        this.notes});
}