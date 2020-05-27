import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  UserModel({this.firebaseUser, uid, email, displayName, photoUrl, metadata})
      : this.uid = firebaseUser?.uid ?? uid,
        this.email = firebaseUser?.email ?? email,
        this.displayName = firebaseUser?.displayName ?? displayName,
        this.photoUrl = firebaseUser?.photoUrl ?? photoUrl,
        this.metadata = firebaseUser?.metadata ?? metadata;

  FirebaseUser firebaseUser;
  final String uid;
  final String email;
  final String displayName;
  final String photoUrl;
  final FirebaseUserMetadata metadata;
}
