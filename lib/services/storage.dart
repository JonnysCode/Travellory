import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travellory/logger.dart';


class Storage{

  static final String USER_PROFILE_PICTURES = 'profile-pictures/';

  /// this method can be called to upload files to the firebase storage.
  /// it takes 2 parameter (optional 3rd)
  /// file: the file to upload
  /// directory: the directory on the firebase storage
  /// (optional) filename: the filename with which it should be uploaded
  static Future<String> uploadFile(File file, String directory, {String filename}) async {
    final log = getLogger('Storage');

    if(filename == null){
      log.d('no filename provided, will use original file name');
      filename = path.basename(file.path);
    }
    log.d("Will upload file: "+filename);
    StorageReference storageReference = FirebaseStorage.instance
        .ref().child(directory+'/'+filename);

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;

    String fileURL = await storageReference.getDownloadURL();
    log.d("FileURL of uploaded file: "+fileURL);

    return fileURL;
  }
}



