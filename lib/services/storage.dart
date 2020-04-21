import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:travellory/logger.dart';

class Storage{



  static final String USER_PROFILE_PICTURES = 'profile-pictures/';

  static Future<String> uploadFile(File file, String directory, {String filename}) async {
    final log = getLogger('Storage');

    if(filename == null){
      filename = path.basename(file.path);
    }
    log.d("File: "+file.path);
    StorageReference storageReference = FirebaseStorage.instance
        .ref().child(directory+'/'+filename);

    final StorageUploadTask uploadTask = storageReference.putFile(file);
    await uploadTask.onComplete;
    String fileURL = await storageReference.getDownloadURL();

    log.d("File: "+file.path);
    return fileURL;
  }
}



