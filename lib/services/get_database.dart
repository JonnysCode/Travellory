import 'package:travellory/models/trip_model.dart';

List<TripModel> createTrips(dbTrips) {
  // add to trips from DB to tripModels
  List<TripModel> trips = <TripModel>[];
  for (Object dbTrip in dbTrips) {
    TripModel trip = TripModel.fromData(dbTrip);
    trips.add(trip);
  }
  tripModels = trips;
  return tripModels;
}
