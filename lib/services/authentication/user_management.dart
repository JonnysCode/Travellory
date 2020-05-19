import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UserManagement {
  static Future<HttpsCallableResult> setUsername(FirebaseUser user) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-setUsername',
    );
    return callable.call({'uid': '${user.uid}', 'displayName': '${user.displayName}'});
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-isUsernameAvailable',
    );
    final dynamic result = await callable.call({'displayName': '$username'});
    return result.data['isAvailable'];
  }

  static Future<dynamic> getAchievements(String userUID) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-getAchievements',
    );
    final dynamic result = await callable.call({'userUID': '${userUID}'});
    print("achievements: "+result.data.toString());
    return result.data;
  }

}
