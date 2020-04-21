import 'package:travellory/models/abstract_model.dart';

class ActivityModel extends Model {
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

  void init(){
    _initImagePath();
  }

  void _initImagePath(){
    imagePath = 'assets/images/activity/activity_${(imageNr + 1).toString()}.png';
  }

  @override
  Map<String, dynamic> toMap(){
    return {
      'category': category,
      'title': title,
      'description': description,
      'location': location,
      'startDate': startDate,
      'startTime': startTime,
      'endDate': endDate,
      'endTime': endTime,
      'notes': notes
    };
  }
}
