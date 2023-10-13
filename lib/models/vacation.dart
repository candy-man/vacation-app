import 'package:vacationapp/models/vacation_status.dart';

class Vacation {
  final String id;
  final int duration;
  final DateTime startDate;
  final DateTime endDate;
  final String userId;
  final String? details;
  final VacationStatus vacationStatus;

  Vacation(
      {required this.id,
      required this.duration,
      required this.startDate,
      required this.endDate,
      required this.userId,
      this.details,
      required this.vacationStatus});

  factory Vacation.fromJsonFirebase(String id, Map<String, dynamic> json) {
    return Vacation(
        id: id,
        duration: json['duration'] as int,
        startDate: DateTime.parse(json['startDate'] as String),
        endDate: DateTime.parse(json['endDate'] as String),
        userId: json['userId'] as String,
        details: json['details'] as String?,
        vacationStatus: VacationStatus.fromMap(json['vacationStatus'] as Map));
  }

  Map<String, dynamic> convertToJson() {
    return {
      "id": id,
      "duration": duration,
      "startDate": startDate,
      "endDate": endDate,
      "userId": userId,
      "details": details,
      "vacationStatus": vacationStatus.convertToJson()
    };
  }
}
