import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/trip_model.dart';

Future<List<TripModel>> getTripsFromDatabase(String userUID) async {
  final log = getLogger('_TripListState');
  final HttpsCallable callable =
  CloudFunctions.instance.getHttpsCallable(functionName: 'trips-getTrips');
  List<dynamic> trips = [];
  try {
    final HttpsCallableResult result = await callable.call(_getUserMap(userUID));
    trips = result.data;
  } on CloudFunctionsException catch (e) {
    log.e('caught firebase functions exception');
    log.e(e.code);
    log.e(e.message);
    log.e(e.details);
  } on Exception catch (e) {
    log.w('caught generic exception');
    log.w(e);
  }
  return _createTrips(trips);
}

Map<String, dynamic> _getUserMap(String userUID) {
  return {"userUID": userUID};
}

List<TripModel> _createTrips(dbTrips) {
  // add to trips from DB to tripModels
  List<TripModel> trips = <TripModel>[];
  for (var dbTrip in dbTrips) {
    TripModel trip = TripModel.fromData(dbTrip);
    trips.add(trip);
  }
  return trips;
}