import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/services/authentication/user_management.dart';
import 'package:travellory/utils/logger.dart';

class AchievementsProvider extends ChangeNotifier{
  AchievementsProvider(){
    _achievements = Achievements();
  }

  final log = getLogger('AchievementsProvider');

  bool isFetchingAchievements = false;

  Achievements _achievements;
  UserModel _user;

  Achievements get achievements => _achievements;
  UserModel get user => _user;

  set user(UserModel user){
    _user = user;
  }

  void init(UserModel user){
    _user = user;
    unawaited(_fetchAchievements());
  }

  void update() async {
    await _fetchAchievements();
  }


  Future<void> _fetchAchievements() async {
    isFetchingAchievements = true;
    try {
      dynamic result = await UserManagement().getAchievements(_user.uid);
      _achievements = Achievements.fromData(result);
    } on PlatformException catch (error) {
      log.e(error.code+" "+error.message);
    }
    isFetchingAchievements = false;
    notifyListeners();
  }
}