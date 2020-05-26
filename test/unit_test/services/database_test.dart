import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/services/cloud/add_database.dart';
import 'package:travellory/src/services/cloud/edit_database.dart';
import 'package:travellory/src/services/cloud/delete_database.dart';

final PublicTransportModel publicTransport = PublicTransportModel()
  ..transportationType = 'train'
  ..departureLocation = 'Los Angeles'
  ..departureTime = '13:35'
  ..arrivalLocation = 'Las Vegas'
  ..arrivalTime = '15:40';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('Tests if Database Adder fails', () async {
    DatabaseAdder adder = DatabaseAdder();
    String wrongFunctionName = 'FailTest';

    Future<bool> added = adder.addModel(publicTransport, wrongFunctionName);
    bool result = await added;

    expect(result, isFalse);
  });

  test('Tests if Database Deleter fails', () async {
    DatabaseDeleter adder = DatabaseDeleter();
    String wrongFunctionName = 'FailTest';

    Future<bool> deleted = adder.deleteModel(publicTransport, wrongFunctionName);
    bool result = await deleted;

    expect(result, isFalse);
  });

  test('Tests if Database Editor fails', () async {
    DatabaseEditor adder = DatabaseEditor();
    String wrongFunctionName = 'FailTest';

    Future<bool> edited = adder.editModel(publicTransport, wrongFunctionName);
    bool result = await edited;

    expect(result, isFalse);
  });
}
