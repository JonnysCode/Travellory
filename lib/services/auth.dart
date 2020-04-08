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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create User object based on firebase user
  UserModel _userFromFirebaseUser(FirebaseUser user) {
    return user != null
        ? UserModel(uid: user.uid, displayName: user.displayName)
        : null;
  }

  // auth change user stream
  @override
  Stream<UserModel> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // get current user
  @override
  Future getCurrentUser() async{
    return await _auth.currentUser();
  }

  // sign in anonymously
  @override
  Future signInAnonymously() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString()); // todo: error handling -> logging
      return null;
    }
  }

  // sign in with email and password
  @override
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString()); // todo: logging and error handling
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
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      UserUpdateInfo updateInfo = UserUpdateInfo()
        ..displayName = displayName;

      await firebaseUser.updateProfile(updateInfo);
      await firebaseUser.reload();
      firebaseUser = await _auth.currentUser();

      UserManagement.setUsername(firebaseUser);

      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString()); // todo: logging and error handling
      return null;
    }
  }

  // register with phone

  // register with google

  // register with facebook

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString()); // todo: exeption handling, logging
      return null;
    }
  }
}
