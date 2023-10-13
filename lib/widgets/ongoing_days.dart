import 'package:flutter/material.dart';
import 'package:vacationapp/models/vacation.dart';

import '../shared/colors.dart';
import '../shared/data_helper.dart';

class OngoingDays extends StatelessWidget {
  final Vacation vacation;
  const OngoingDays({super.key, required this.vacation});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 7),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: getStatusColor(2),
          child: Center(
            child: Text(
              "Ongoing: ${formatDate(vacation.startDate)} / ${formatDate(vacation.endDate)}",
              style: const TextStyle(
                color: CustomColors.color2,
                fontSize: 20,
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(1.0),
          margin: const EdgeInsets.symmetric(horizontal: 10.0),
          decoration: getStatusColor(2),
          child: Container(
            padding: const EdgeInsets.fromLTRB(5, 10, 5, 7),
            color: CustomColors.color2,
            child: Center(
              child: Text(
                vacation.duration.toString(),
                style: const TextStyle(
                  color: CustomColors.colorOngoing,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
