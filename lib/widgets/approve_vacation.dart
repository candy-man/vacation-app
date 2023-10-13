import 'package:flutter/material.dart';
import 'package:vacationapp/models/vacation.dart';
import 'package:vacationapp/shared/constants.dart';
import '../models/user_model.dart';
import '../services/vacation_service.dart';
import '../shared/colors.dart';
import '../shared/data_helper.dart';

approveVacation(BuildContext context, Vacation vacation, UserData userData,
    Function refresh) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Approve vacation?'),
        content: Text(
            "${formatDate(vacation.startDate)} / ${formatDate(vacation.endDate)} (${vacation.duration} days)"),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text(
              'Approve',
              style: TextStyle(color: CustomColors.colorAccepted),
            ),
            onPressed: () async {
              await VacationService().updateVacationStatus(
                  vacation.id, approvedStatus, "Approved");
              refresh();
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
        child: Text('Approved!'),
      ),
      duration: Duration(milliseconds: 1500),
      padding: EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
