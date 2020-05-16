import 'package:flutter/material.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/database/get_database.dart';

class TempBookingsProvider extends ChangeNotifier {
  TempBookingsProvider(UserModel user){
    this.user = user;
  }

  final DatabaseGetter _databaseGetter = DatabaseGetter();

  UserModel user;
  List<AccommodationModel> accommodations;

  Future<void> fetchAccommodations() async {
    accommodations = <AccommodationModel>[];
    accommodations = await _databaseGetter.getEntriesFromDatabase(
        user.uid, DatabaseGetter.getAccommodations);
    notifyListeners();
  }

}