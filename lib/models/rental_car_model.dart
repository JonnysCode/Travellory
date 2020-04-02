class RentalCarModel {
  final String bookingReference;
  final String company;
  final String pickupLocation;
  final String pickupDate;
  final String pickupTime;
  final String returnLocation;
  final String returnDate;
  final String returnTime;
  final String carDescription;
  final String carNumberPlate;
  final String notes;

  RentalCarModel(
      {this.bookingReference,
        this.company,
        this.pickupLocation,
        this.pickupDate,
        this.pickupTime,
        this.returnLocation,
        this.returnDate,
        this.returnTime,
        this.carDescription,
        this.carNumberPlate,
        this.notes});
}