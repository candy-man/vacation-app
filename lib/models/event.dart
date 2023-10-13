import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:vacationapp/models/vacation.dart';
import 'package:vacationapp/services/user_service.dart';

import '../shared/colors.dart';

class EventDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  EventDataSource(List<Event> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return _getEventData(index).from;
  }

  @override
  DateTime getEndTime(int index) {
    return _getEventData(index).to;
  }

  @override
  String getSubject(int index) {
    return _getEventData(index).eventName;
  }

  @override
  Color getColor(int index) {
    return _getEventData(index).background;
  }

  @override
  bool isAllDay(int index) {
    return _getEventData(index).isAllDay;
  }

  Event _getEventData(int index) {
    final dynamic meeting = appointments![index];
    late final Event meetingData;
    if (meeting is Event) {
      meetingData = meeting;
    }
    return meetingData;
  }
}

class Event {
  /// Creates a meeting class with required details.

  /// Event name which is equivalent to subject property of [Appointment].
  String eventName;

  /// From which is equivalent to start time property of [Appointment].
  DateTime from;

  /// To which is equivalent to end time property of [Appointment].
  DateTime to;

  /// Background which is equivalent to color property of [Appointment].
  Color background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool isAllDay;

  Event(this.eventName, this.from, this.to, this.background, this.isAllDay);

  static Future<Event> create(Vacation vacation) async {
    var userData = await UserService(uid: vacation.userId).getUserById();
    return Event(
        "${userData.firstName} ${userData.lastName} (${vacation.duration}VD)",
        vacation.startDate,
        vacation.endDate,
        getStatusColor(vacation.vacationStatus.id).color!,
        true);
    // return Event(
    //   eventName: "Test",
    //   background: Colors.blue,
    //   from: DateTime.parse(vacation.startDate),
    //   to: DateTime.parse(vacation.endDate),
    //   isAllDay: true,
    // );

    // factory Event.fromVacation(Vacation vacation) {
    //   var test = UserService(uid: vacation.userId).getUserById();

    //   throw Exception("test");

    //   // Vacation(
    //   //     id: id,
    //   //     duration: json['duration'] as int,
    //   //     startDate: json['startDate'] as String,
    //   //     endDate: json['endDate'] as String,
    //   //     userId: json['userId'] as String,
    //   //     vacationStatus: VacationStatus.fromMap(json['vacationStatus'] as Map));
    // }
  }
}
