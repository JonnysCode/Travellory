class FriendModel {
  FriendModel(this.uid, this.username, this.photoURL, this.homeCountry);

  FriendModel.fromJson(data)
      : uid = data['uid'],
        username = data['displayName'],
        photoURL = data['photoURL'],
        homeCountry = data['homeCountry'];

  final String uid;
  final String username;
  final String photoURL;
  final String homeCountry;

}