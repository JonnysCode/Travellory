
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as path;
import 'package:mockito/mockito.dart';
import 'package:travellory/services/storage.dart';

class MockStorage extends Mock implements Storage {
  @override
  Future<String> uploadFile(File file, String directory, {String filename}) async {
    if(filename == null){
      filename = path.basename(file.path);
    }
    return directory+filename;
  }
}

void main() {

  test('test uploading a file', () async {
    File file = File('assets/photo_camera.png');
    Storage storage = MockStorage();
    String fileUrl = await storage.uploadFile(file, userProfilePicturesDir);
    expect(fileUrl, userProfilePicturesDir+path.basename(file.path));
  });

}