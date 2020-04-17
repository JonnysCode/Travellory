import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/logger.dart';
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


void _getTrips(String userUID) async {
  final log = getLogger('_TripListState');
  final HttpsCallable callable =
  CloudFunctions.instance.getHttpsCallable(functionName: 'trips-getTrips');
  try {
    final HttpsCallableResult result = await callable.call(getTrips(userUID));
    List<dynamic> trips = result.data;
    createTrips(trips);
  } on CloudFunctionsException catch (e) {
    log.e('caught firebase functions exception');
    log.e(e.code);
    log.e(e.message);
    log.e(e.details);
  } on Exception catch (e) {
    log.w('caught generic exception');
    log.w(e);
  }
}

Map<String, dynamic> getTrips(String userUID) {
  return {"userUID": userUID};
}