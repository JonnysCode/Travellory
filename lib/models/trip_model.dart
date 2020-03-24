
class TripModel {
  String name;
  DateTime startDate;
  DateTime endDate;
  String destination;
  String imagePath;
  int imageNr;
  int index;

  TripModel({
    this.name,
    this.startDate,
    this.endDate,
    this.destination,
    this.imageNr,
    this.index
  }){
    this.imagePath = 'assets/images/home/trip/trip_' + imageNr.toString() + '.png';
  }
}

List<TripModel> tripModels = [
  TripModel(
    name: 'Castle Discovery',
    startDate: DateTime(2020, 5, 12),
    endDate: DateTime(2020, 5, 25),
    destination: 'Munich',
    imageNr: 3
  ),
  TripModel(
      name: 'Beach Relaxation',
      startDate: DateTime(2020, 3, 24),
      endDate: DateTime(2020, 4, 8),
      destination: 'Maledives',
      imageNr: 1
  ),
  TripModel(
      name: 'City Trip',
      startDate: DateTime(2020, 7, 4),
      endDate: DateTime(2020, 7, 13),
      destination: 'San Francisco',
      imageNr: 2
  ),
];