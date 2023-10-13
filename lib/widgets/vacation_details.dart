import 'package:flutter/material.dart';
import 'package:vacationapp/models/vacation.dart';
import '../shared/colors.dart';
import '../shared/data_helper.dart';

vacationDetails(BuildContext context, Vacation vacation) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Vacation details'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Start date:"),
                  const Text("End date:"),
                  const Text("Status:"),
                  const Text("Duration:"),
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    width: 75,
                    child: const Text("Details:"),
                  )
                ],
              ),
              Container(
                padding: const EdgeInsets.only(left: 5.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(formatDate(vacation.startDate)),
                    Text(formatDate(vacation.endDate)),
                    Container(
                      decoration: getStatusColor(vacation.vacationStatus.id),
                      child: Text(
                        vacation.vacationStatus.statusName,
                        style: const TextStyle(color: CustomColors.color2),
                      ),
                    ),
                    Text("${vacation.duration} days"),
                    const SizedBox(height: 35.0),
                  ],
                ),
              ),
            ]),
            if (vacation.details != null)
              Align(
                alignment: Alignment.topLeft,
                child: Text(vacation.details!),
              )
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
