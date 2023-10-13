import 'package:flutter/material.dart';
import 'package:vacationapp/models/vacation.dart';
import '../models/user_model.dart';
import '../services/vacation_service.dart';
import '../shared/colors.dart';
import '../shared/data_helper.dart';

deleteVacation(BuildContext context, Vacation vacation, UserData userData) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Cancel vacation?'),
        content: Text(
            "${formatDate(vacation.startDate)} / ${formatDate(vacation.endDate)} (${vacation.duration} days)"),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Delete',
              style: TextStyle(color: CustomColors.color4),
            ),
            onPressed: () async {
              await VacationService()
                  .deleteVacation(vacation, userData.availableVacationDays);
              // ignore: use_build_context_synchronously
              showSnackBar(context);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

showSnackBar(context) {
  return ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      backgroundColor: CustomColors.color1,
      elevation: 0.0,
      content: Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Deleted!'),
      ),
      duration: Duration(milliseconds: 1500),
      padding: EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
