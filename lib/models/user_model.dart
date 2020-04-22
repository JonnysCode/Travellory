import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({this.firebaseUser, uid, email, displayName, photoUrl, metadata}):
    this.uid = firebaseUser != null ? firebaseUser.uid != null ? firebaseUser.uid : uid : uid,
    this.email = firebaseUser != null ? firebaseUser.email != null ? firebaseUser.email : email : email,
    this.displayName = firebaseUser != null ? firebaseUser.displayName != null ? firebaseUser.displayName : displayName : displayName,
    this.photoUrl = firebaseUser != null ? firebaseUser.photoUrl != null ? firebaseUser.photoUrl : photoUrl : photoUrl,
    this.metadata = firebaseUser != null ? firebaseUser.metadata != null ? firebaseUser.metadata : metadata : metadata;

  FirebaseUser firebaseUser;
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final FirebaseUserMetadata metadata;


}