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
  
  static Future<HttpsCallableResult> setHomeCountry(String uid, String homeCountry) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-setHomeCountry',
    );
    return callable.call({'uid': uid, 'homeCountry': homeCountry});
  }

  static Future<String> getHomeCountry(String uid) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-getPublicUserInformation',
    );
    final result = await callable.call({'uid': uid});
    return result.data['homeCountry'];
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
