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
  String notes;

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
