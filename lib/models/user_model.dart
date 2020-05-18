import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({this.firebaseUser, uid, email, displayName, photoUrl, hometown, metadata})
      : this.uid = firebaseUser?.uid ?? uid,
        this.email = firebaseUser?.email ?? email,
        this.displayName = firebaseUser?.displayName ?? displayName,
        this.photoUrl = firebaseUser?.photoUrl ?? photoUrl,
        // TODO(hessgia1): fetch hometown from db
        this.hometown = "Hometown",
        this.metadata = firebaseUser?.metadata ?? metadata;

  FirebaseUser firebaseUser;
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final String hometown;
  final FirebaseUserMetadata metadata;
}
