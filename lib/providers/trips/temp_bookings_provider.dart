import 'package:flutter/material.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/get_database.dart';

class TempBookingsProvider extends ChangeNotifier {
  TempBookingsProvider(UserModel user){
    this._user = user;
  }

  final DatabaseGetter _databaseGetter = DatabaseGetter();

  UserModel _user;
  List<AccommodationModel> accommodations;

  Future<List<AccommodationModel>> fetchAccommodations() async {
    accommodations = await _databaseGetter.getEntriesFromDatabase(
        _user.uid, DatabaseGetter.getTempAccommodations);
    return accommodations;
  }

}