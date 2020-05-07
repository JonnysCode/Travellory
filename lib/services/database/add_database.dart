import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/utils/logger.dart';
import 'package:travellory/models/abstract_model.dart';

class DatabaseAdder {
  factory DatabaseAdder() {
    return _instance;
  }

  DatabaseAdder._privateConstructor();

  static final DatabaseAdder _instance = DatabaseAdder._privateConstructor();

  static const int _maxCount = 50;
  static const String addTrip = 'trips-addTrip';

  static int _count = 0;

  final log = getLogger('DatabaseAdder');

  // adds Model to the database
  Future<bool> addModel(Model model, String correspondingFunctionName) async {
    if(_count++ >= _maxCount){
      log.w('maxCount exceeded in AddModel');
      return false;
    }
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: correspondingFunctionName);
    try {
      log.d('JSON data for function call $correspondingFunctionName: ${model.toMap()}');
      final HttpsCallableResult result = await callable.call(model.toMap());
      log.i(result.data);
      return Future<bool>.value(true);
    } on CloudFunctionsException catch (e) {
      log.i('caught firebase functions exception');
      log.e(e.code);
      log.e(e.message);
      log.e(e.details);
    } on Exception catch (e) {
      log.i('caught generic exception');
      log.i(e);
    }
    return Future<bool>.value(true);
  }
}
