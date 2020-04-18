import 'package:firebase_auth/firebase_auth.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/user_management.dart';

abstract class BaseAuthService {
  Future signInAnonymously();
  Future signInWithEmailAndPassword(String email, String password);
  Future reauthenticate(String oldPassword);
  Future changePassword(String password);
  Future registerWithEmailAndPassword(
      String email, String password, String displayName);
  Future signOut();
  Future getCurrentUser();
  Stream<UserModel> get user;
  set user(Stream<UserModel> user);
}

class AuthService implements BaseAuthService {
  AuthService({this.auth, this.userStream}) {
    if (auth == null) {
      auth = FirebaseAuth.instance;
    }
  }

  FirebaseAuth auth;
  Stream<UserModel> userStream;

  final log = getLogger('AuthService');

  @override
  set user(Stream<UserModel> user) {
    userStream = user;
  }

  // create User object based on firebase user
  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? UserModel(uid: user.uid, displayName: user.displayName)
        : null;
  }

  // auth change user stream
  @override
  Stream<UserModel> get user {
    return userStream == null
        ? auth.onAuthStateChanged.map(_userFromFirebaseUser)
        : userStream;
  }

  // get current user
  @override
  Future getCurrentUser() async {
    return auth.currentUser();
  }

  // sign in anonymously
  @override
  Future signInAnonymously() async {
    try {
      final AuthResult result = await auth.signInAnonymously();
      final FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      // todo: error handling -> logging
      return null;
    }
  }

  // sign in with email and password
  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final AuthResult result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      final FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      log.e(e.toString());
      return Future.error(e);
    }
  }

  // register with email and password
  @override
  Future registerWithEmailAndPassword(
      String email, String password, String displayName) async {
    try {
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      final UserUpdateInfo updateInfo = UserUpdateInfo()
        ..displayName = displayName;

      await firebaseUser.updateProfile(updateInfo);
      await firebaseUser.reload();
      firebaseUser = await auth.currentUser();

      await UserManagement.setUsername(firebaseUser);

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      log.e(e.toString());
      if(auth.currentUser() != null){
        await _deleteCurrentUser();
      }
      return Future.error(e);
    }
  }

  //reauthenticate before security-sensitive action (f.e. change password)
  @override
  Future reauthenticate(String oldPassword) async {
    final FirebaseUser user = await auth.currentUser();
    final String email = user.email;
    final AuthCredential credential =
        EmailAuthProvider.getCredential(email: email, password: oldPassword);
    return user.reauthenticateWithCredential(credential);
  }

  //change password
  @override
  Future changePassword(String password) async {
    final FirebaseUser user = await auth.currentUser();
    return user.updatePassword(password);
  }

  // sign out
  @override
  Future signOut() async {
    try {
      return await auth.signOut();
    } catch (e) {
      // todo: exeption handling, logging
      return null;
    }
  }

  // delete current user
 Future _deleteCurrentUser() async {
   await auth.currentUser().then((user) {
     user.delete();
   }).catchError((e) {
     log.e('User was not deleted');
   });
 }
}
