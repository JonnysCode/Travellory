import 'package:travellory/models/abstract_model.dart';

class ActivityModel extends Model {
  ActivityModel(
      {this.tripUID = '',
      this.uid = '',
      this.category = '',
      this.title = '',
      this.description = '',
      this.location = '',
      this.startDate = '',
      this.startTime = '',
      this.endDate = '',
      this.endTime = '',
      this.imageNr,
      this.notes = '',
      this.latitude = 0.0,
      this.longitude = 0.0});

  ActivityModel.fromData(activity) {
    tripUID = activity["tripUID"];
    uid = activity["uid"];
    category = activity["category"];
    title = activity["title"];
    description = activity["description"];
    location = activity["location"];
    startDate = activity["startDate"];
    startTime = activity["startTime"];
    endDate = activity["endDate"];
    endTime = activity["endTime"];
    imageNr = activity["imageNr"];
    notes = activity["notes"];
    latitude = activity["latitude"];
    longitude = activity["longitude"];
    imagePath = 'assets/images/activity/activity_${imageNr.toString()}.png';
  }

  String tripUID;
  String uid;
  String category;
  String title;
  String description;
  String location;
  String startDate;
  String startTime;
  String endDate;
  String endTime;
  int imageNr;
  String imagePath;
  String notes;
  double latitude;
  double longitude;

  void init() {
    _initImagePath();
  }

  void _initImagePath() {
    imagePath =
        'assets/images/activity/activity_${(imageNr + 1).toString()}.png';
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      "tripUID": tripUID,
      "uid": uid,
      "category": category,
      "title": title,
      "description": description,
      "location": location,
      "startDate": startDate,
      "startTime": startTime,
      "endDate": endDate,
      "endTime": endTime,
      "imageNr": imageNr,
      "notes": notes,
      "latitude": latitude,
      "longitude": longitude
    };
  }
}

List<ActivityModel> activityModels = <ActivityModel>[];
