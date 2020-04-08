import 'package:firebase_auth/firebase_auth.dart';
import 'package:travellory/models/user_model.dart';

abstract class BaseAuthService {
  Future signInAnonymously();
  Future signInWithEmailAndPassword(String email, String password);
  Future registerWithEmailAndPassword(String email, String password);
  Future reauthenticate (String oldPassword, String newPassword);
  Future changePassword(String password);
  Future signOut();
  Stream<UserModel> get user;
}

class AuthService implements BaseAuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create User object based on firebase user
  UserModel _userFromFirebaseUser(FirebaseUser user){
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserModel> get user {
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

  //reauthenticate before security-sensitive action (f.e. change password)
  Future reauthenticate (String oldPassword, String newPassword) async {
    //TODO: fluetfab call success/error messages
    FirebaseUser user = await _auth.currentUser();
    String email = user.email;
    AuthCredential credential = EmailAuthProvider.
    getCredential(email: email, password: oldPassword);
    user.reauthenticateWithCredential(credential).then((onValue){
      print("success reauth");
      changePassword(newPassword);
    }).catchError((onError){
      print("error reauth"+onError.toString());
    });
  }

  //change password
  Future changePassword(String password) async {
    //TODO: fluetfab call success/error messages
    FirebaseUser user = await _auth.currentUser();
    user.updatePassword(password).then((onValue){
      print("success pw");
    }).catchError((onError){
      print("error pw: "+onError.toString());
    });
  }



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