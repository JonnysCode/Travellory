import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/models/abstract_model.dart';

class DatabaseAdder {
  // adds Model to the database
  static Future<bool> addModel(Model model, String correspondingFunctionName) async {
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: correspondingFunctionName);
    try {
      final HttpsCallableResult result = await callable.call(model.toMap());
      print(result.data);
      return Future<bool>.value(true);
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
    return Future<bool>.value(true);
  }
}