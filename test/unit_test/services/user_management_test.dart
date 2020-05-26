import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:travellory/src/services/authentication/user_management.dart';

void main() {
  MethodCall logMethodCall;

  // mock the cloud functions channel
  MethodChannel channel =
  const MethodChannel('plugins.flutter.io/cloud_functions');

  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();

    // register the mock handler
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      logMethodCall = methodCall;
    });
  });

  tearDown(() {
    // unregister the mock handler
    channel.setMockMethodCallHandler(null);
  });

  test('test set home country', () async {
    const String uid = 'uid';
    const String homeCountry = 'Switzerland';
    const parameters = {'uid': uid, 'homeCountry': homeCountry};

    await UserManagement().setHomeCountry(uid, homeCountry);

    expect(logMethodCall.arguments['functionName'],
        equals('user-setHomeCountry'));
    expect(logMethodCall.arguments['parameters'], equals(parameters));
  });
}