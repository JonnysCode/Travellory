import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:travellory/services/storage.dart';
import 'package:travellory/models/user_model.dart';

class UserManagement {
  static void setUsername(FirebaseUser user) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-setUsername',
    );
    callable.call({'uid': '${user.uid}', 'displayName': '${user.displayName}'});
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-isUsernameAvailable',
    );
    final dynamic result = await callable.call({'displayName': '$username'});
    return result.data['isAvailable'];
  }

  static Future<bool> saveUserProfilePicture(File image, UserModel user, String fileURL) async {
    final directory = await getApplicationDocumentsDirectory();
    File file = await image.copy(directory.path+'/'+Storage.USER_PROFILE_PICTURES+user.uid);
    FirebaseUser firebaseUser = user.firebaseUser;

    final UserUpdateInfo updateInfo = UserUpdateInfo()
      ..photoUrl = fileURL;

    await firebaseUser.updateProfile(updateInfo);
    await firebaseUser.reload();
    final auth = FirebaseAuth.instance;
    user.firebaseUser = await auth.currentUser();

    return file.exists();
  }

  static Future<String> getUserProfilePicturePath(UserModel user) async {
    final directory = await getApplicationDocumentsDirectory();
    final extension = user.photoUrl.lastIndexOf('.');

    File file = new File(directory.path+'/'+Storage.USER_PROFILE_PICTURES+user.uid);
    if(file.exists() != null){
      return file.path;
    }else{
      // download from firebase
      return null;
    }
  }


}
