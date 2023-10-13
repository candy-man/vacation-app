import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../shared/colors.dart';
import '../models/event.dart';

class CalendarCustom extends StatelessWidget {
  final List<Event> events;
  const CalendarCustom({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      selectionDecoration: BoxDecoration(
        border: Border.all(color: CustomColors.color1),
      ),
      backgroundColor: CustomColors.color2,
      showTodayButton: true,
      showNavigationArrow: true,
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      cellEndPadding: 0,
      cellBorderColor: CustomColors.color5,
      headerStyle: const CalendarHeaderStyle(
        backgroundColor: CustomColors.color1,
        textStyle: TextStyle(
          fontSize: 20,
          color: Colors.white,
        ),
      ),
      viewHeaderStyle: const ViewHeaderStyle(
        dayTextStyle: TextStyle(
          fontSize: 15,
        ),
      ),
      todayHighlightColor: CustomColors.color1,
      monthViewSettings: const MonthViewSettings(
        appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
        agendaItemHeight: 30,
        showAgenda: true,
        agendaViewHeight: 100,
        agendaStyle: AgendaStyle(
          backgroundColor: CustomColors.color5,
          dateTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          dayTextStyle: TextStyle(color: Colors.black, fontSize: 15),
        ),
        monthCellStyle: MonthCellStyle(
          trailingDatesTextStyle: TextStyle(fontSize: 15),
          leadingDatesTextStyle: TextStyle(fontSize: 15),
          textStyle: TextStyle(fontSize: 15),
        ),
      ),
    );
  }

  // List<Event> _getDataSource() {
  //   final List<Event> Events = <Event>[];
  //   final DateTime today = DateTime.now();

  //   final DateTime startTime = DateTime.parse("2023-08-20");
  //   final DateTime endTime = startTime.add(const Duration(hours: 48));

  //   Events.add(
  //       Event('Conference', startTime, endTime, Color(0xff8E9B5E), false));
  //   Events.add(Event('Test', startTime, endTime,
  //       const Color.fromARGB(255, 50, 168, 82), false));
  //   Events.add(Event('Test', startTime, endTime,
  //       const Color.fromARGB(255, 50, 168, 82), false));
  //   Events.add(Event('Test', startTime, endTime,
  //       const Color.fromARGB(255, 50, 168, 82), false));
  //   Events.add(Event('Test', startTime, endTime,
  //       const Color.fromARGB(255, 50, 168, 82), false));
  //   Events.add(Event('Test', startTime, endTime,
  //       const Color.fromARGB(255, 50, 168, 82), false));
  //   // Events.add(
  //   //     Event('Test', startTime, endTime, const Color(0xFF0F8644), false));
  //   // Events.add(
  //   //     Event('Test', startTime, endTime, const Color(0xFF0F8644), false));
  //   // Events.add(
  //   //     Event('Test', startTime, endTime, const Color(0xFF0F8644), false));
  //   // Events.add(
  //   //     Event('Test', startTime, endTime, const Color(0xFF0F8644), false));
  //   return Events;
  // }
}
