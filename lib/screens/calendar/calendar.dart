import 'package:flutter/cupertino.dart';

import '../../models/event.dart';
import '../../models/vacation.dart';
import '../../services/vacation_service.dart';
import '../../shared/loading.dart';
import '../../widgets/calendar_custom.dart';

class Clendar extends StatelessWidget {
  const Clendar({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Vacation>>(
        future: VacationService().vacationsAll(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          }

          var vacations = snapshot.data!;
          var events =
              vacations.map((vacation) => Event.create(vacation)).toList();

          return FutureBuilder<List<Event>>(
              future: Future.wait(events),
              builder: (context, AsyncSnapshot<List<Event>> snapshot) {
                if (!snapshot.hasData) return const Loading();
                var events = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          CalendarCustom(events: events),
                        ],
                      ),
                    ),
                  ],
                );
              });

          // return const Column(
          //   crossAxisAlignment: CrossAxisAlignment.start,
          //   children: [
          //     Expanded(
          //       child: Row(
          //         children: [
          //           CalendarCustom(events: []),
          //         ],
          //       ),
          //     ),
          //   ],
          // );
        });
  }
}
