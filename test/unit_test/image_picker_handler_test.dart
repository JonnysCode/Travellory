import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('ImagePicker', () {
    const MethodChannel channel =
        MethodChannel('plugins.flutter.io/image_picker');

    final List<MethodCall> log = <MethodCall>[];

    setUp(() {
      channel.setMockMethodCallHandler((MethodCall methodCall) async {
        log.add(methodCall);
        return '';
      });

      log.clear();
    });

    test('passes the image source argument correctly', () async {
      await ImagePicker.pickImage(source: ImageSource.camera);
      await ImagePicker.pickImage(source: ImageSource.gallery);

      expect(
        log,
        <Matcher>[
          isMethodCall('pickImage', arguments: <String, dynamic>{
            'source': 0,
            'maxWidth': null,
            'maxHeight': null,
            'imageQuality': null,
            'cameraDevice': 0
          }),
          isMethodCall('pickImage', arguments: <String, dynamic>{
            'source': 1,
            'maxWidth': null,
            'maxHeight': null,
            'imageQuality': null,
            'cameraDevice': 0
          }),
        ],
      );
    });
  });
}
