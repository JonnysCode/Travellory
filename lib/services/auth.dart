import 'package:firebase_auth/firebase_auth.dart';
import 'package:travellory/models/user.dart';

abstract class BaseAuthService {
  Future signInAnonymously();
  Future signInWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future updatePassword(String newPassword);
  Future signOut();
  Stream<User> get user;
}

class AuthService implements BaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create User object based on firebase user
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anonymously
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
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
      print(e.toString()); // todo: logging and error handling
      return null;
    }
  }

  // sign in with phone number

  // sign in with google

  // sign in with facebook

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      return _userFromFirebaseUser(firebaseUser);
    } catch(e) {
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

  Future updatePassword(String password) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();

    user.updatePassword(password).then((_){
      print("Succesfull changed password");
    }).catchError((error){
      print("Password can't be changed" + error.toString());
      //This might happen, when the wrong password is in, the user isn't found, or if the user hasn't logged in recently.
    });
  }

}