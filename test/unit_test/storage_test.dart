
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:mockito/mockito.dart';
import 'package:travellory/services/storage.dart';

class MockStorage extends Mock implements Storage {
  static Future<String> uploadFile(File file, String directory, {String filename}) async {
    if(filename == null){
      filename = path.basename(file.path);
    }
    return directory+filename;
  }
}

void main() {

  test('test uploading a file', () async {
    File file = File('assets/photo_camera.png');
    String fileUrl = await MockStorage.uploadFile(file, Storage.USER_PROFILE_PICTURES);
    expect(fileUrl, Storage.USER_PROFILE_PICTURES+path.basename(file.path));
  });

}