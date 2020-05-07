import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travellory/utils/logger.dart';

const String userProfilePicturesDir = 'profile-pictures/';
const String defaultUserProfilePicture =
    'https://firebasestorage.googleapis.com/v0/b/travellory-9b789.appspot.com/o/profile-pictures%2Fphoto_camera.png?alt=media&token=5e138c64-709e-4172-9b89-664cdc28a347';

class Storage {
  /// this method can be called to upload files to the firebase storage.
  /// it takes 2 parameter (optional 3rd)
  /// file: the file to upload
  /// directory: the directory on the firebase storage
  /// (optional) filename: the filename with which it should be uploaded
  Future<String> uploadFile(File file, String directory,
      {String filename}) async {
    final log = getLogger('Storage');

    filename ??= path.basename(file.path);

    log.d('Will upload file: $filename');
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child('$directory/$filename');

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;

    final String fileURL = await storageReference.getDownloadURL();
    log.d('FileURL of uploaded file: $fileURL');

    return fileURL;
  }
}
