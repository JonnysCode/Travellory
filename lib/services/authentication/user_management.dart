import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_functions/cloud_functions.dart';

class UserManagement {
  static Future<HttpsCallableResult> setUsername(FirebaseUser user) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-setUsername',
    );
    return callable.call({'uid': user.uid, 'displayName': user.displayName});
  }

  static Future<bool> isUsernameAvailable(String username) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-isUsernameAvailable',
    );
    final dynamic result = await callable.call({'displayName': username});
    return result.data['isAvailable'];
  }
  
  static Future<HttpsCallableResult> setHomecountry(String uid, String homecountry) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-setHometown',
    );
    return callable.call({'uid': uid, 'hometown': homecountry});
  }

  static Future<String> getHomecountry(String uid) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-getPublicUserInformation',
    );
    final result = await callable.call({'uid': uid});
    return result.data['hometown'];
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
