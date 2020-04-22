import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/abstract_model.dart';

class DatabaseAdder {
  static const int _maxCount = 20;
  static const String addTrip = 'trips-addTrip';

  static int _count = 0;

  final log = getLogger('DatabaseAdder');

  // adds Model to the database
  Future<bool> addModel(Model model, String correspondingFunctionName) async {
    print('Model has been added -> ' + (++_count).toString());
    print('Function name: ' + correspondingFunctionName);
    if(_count >= _maxCount){
      print('WARNING: MaxCount exceeded in AddModel');
      return false;
    }
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: correspondingFunctionName);
    try {
      final HttpsCallableResult result = await callable.call(model.toMap());
      log.i(result.data);
      return Future<bool>.value(true);
    } on CloudFunctionsException catch (e) {
      log.i('caught firebase functions exception');
      log.e(e.code);
      log.e(e.message);
      log.e(e.details);
    } catch (e) {
      log.i('caught generic exception');
      log.i(e);
    }
    return Future<bool>.value(true);
  }
}
