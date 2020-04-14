import 'package:firebase_auth/firebase_auth.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/user_management.dart';

abstract class BaseAuthService {
  Future signInAnonymously();
  Future signInWithEmailAndPassword(String email, String password);
  Future reauthenticate (String oldPassword);
  Future changePassword(String password);
  Future registerWithEmailAndPassword(
      String email, String password, String displayName);
  Future signOut();
  Future getCurrentUser();
  Stream<UserModel> get user;
}

class AuthService implements BaseAuthService {
  AuthService({this.auth}){
    if(auth == null){
      auth = FirebaseAuth.instance;
    }
  }

  FirebaseAuth auth;

  // create User object based on firebase user
  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? UserModel(uid: user.uid, displayName: user.displayName)
        : null;
  }

  // auth change user stream
  @override
  Stream<UserModel> get user {
    return auth.onAuthStateChanged.map(_userFromFirebaseUser);
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
      // todo: logging and error handling
      return null;
    }
  }

  // sign in with phone number

  // sign in with google

  // sign in with facebook

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

      UserManagement.setUsername(firebaseUser);

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      // todo: logging and error handling
      return null;
    }
  }

  // register with phone

  // register with google

  // register with facebook

  //reauthenticate before security-sensitive action (f.e. change password)
  @override
  Future reauthenticate (String oldPassword) async {
    final FirebaseUser user = await auth.currentUser();
    final String email = user.email;
    final AuthCredential credential = EmailAuthProvider.
    getCredential(email: email, password: oldPassword);
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
}
