import 'package:flutter/material.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/services/database/get_database.dart';

class TempBookingsProvider extends ChangeNotifier {
  TempBookingsProvider(UserModel user){
    this._user = user;
    unawaited(fetchAccommodations());
  }

  final DatabaseGetter _databaseGetter = DatabaseGetter();
  final DatabaseDeleter _databaseDeleter = DatabaseDeleter();

  UserModel _user;
  List<AccommodationModel> accommodations;

  Future<void> fetchAccommodations() async {
    accommodations = await _databaseGetter.getEntriesFromDatabase(
        _user.uid, DatabaseGetter.getTempAccommodations);
    notifyListeners();
  }

  Future<bool> deleteAccommodation(AccommodationModel model) async {
    final bool deleted = await _databaseDeleter.deleteModel(model, DatabaseDeleter.deleteTempAccommodation);
    if(deleted) {
      await fetchAccommodations();
      notifyListeners();
    }
    return deleted;
  }

  Future<bool> addAccommodationToTrip(AccommodationModel model, SingleTripProvider trip) async {
    model.tripUID = trip.tripModel.uid;
    final added = await trip.addBooking(model, DatabaseAdder.addAccommodation);
    if(added){
      return await deleteAccommodation(model);
    } else {
      return false;
    }
  }
}