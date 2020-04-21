import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({this.firebaseUser}):
    this.uid = firebaseUser.uid,
    this.email = firebaseUser.email,
    this.displayName = firebaseUser.displayName,
    this.photoUrl = firebaseUser.photoUrl,
    this.metadata = firebaseUser.metadata;

  FirebaseUser firebaseUser;
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final FirebaseUserMetadata metadata;


}