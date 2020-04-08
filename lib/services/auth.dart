import 'package:firebase_auth/firebase_auth.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/services/user_management.dart';

abstract class BaseAuthService {
  Future signInAnonymously();
  Future signInWithEmailAndPassword(String email, String password);
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
<<<<<<< HEAD
  Future getCurrentUser() async {
    return auth.currentUser();
=======
  Future getCurrentUser() async{
    return _auth.currentUser();
>>>>>>> d3a4d1b... Refactor remove code smells
  }

  // sign in anonymously
  @override
  Future signInAnonymously() async {
    try {
<<<<<<< HEAD
      AuthResult result = await auth.signInAnonymously();
      FirebaseUser user = result.user;
=======
      final AuthResult result = await _auth.signInAnonymously();
      final FirebaseUser user = result.user;
>>>>>>> d3a4d1b... Refactor remove code smells
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
<<<<<<< HEAD
      final AuthResult result = await auth.signInWithEmailAndPassword(
=======
      final AuthResult result = await _auth.signInWithEmailAndPassword(
>>>>>>> d3a4d1b... Refactor remove code smells
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
<<<<<<< HEAD
      final AuthResult result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;

      final UserUpdateInfo updateInfo = UserUpdateInfo()
        ..displayName = displayName;

=======
      final AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      final UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = displayName;
>>>>>>> d3a4d1b... Refactor remove code smells
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
