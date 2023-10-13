import 'package:vacationapp/services/user_service.dart';
import 'package:vacationapp/services/vacation_service.dart';
import 'package:vacationapp/shared/constants.dart';

import '../shared/data_helper.dart';

// vacation status

Future handleVacationStatuses() async {
  var users = await UserService().fetchAllUsers();
  var vacations = await VacationService().fetchAllVacationStatusChecks();

  for (var vacation in vacations) {
    var user = users.where((user) => user.uid == vacation.userId).first;

    var startDateToNow = calculateDifference(vacation.startDate);
    var endDateToNow = calculateDifference(vacation.endDate);

    switch (vacation.vacationStatus.id) {
      case approvedStatus:
        if (startDateToNow > 0) continue;
        if (startDateToNow <= 0 && endDateToNow >= 0) {
          await VacationService()
              .updateVacationStatus(vacation.id, ongoingStatus, "Ongoing");
          // UserService(uid: vacation.userId).updateSpentDays();
        }
        if (endDateToNow < 0) {
          await VacationService()
              .updateVacationStatus(vacation.id, endedStatus, "Ended");
          await UserService(uid: vacation.userId)
              .updateSpentDays(user.spentVacationDays + vacation.duration);
        }
        break;
      case pendingStatus:
        if (startDateToNow <= 0) {
          await VacationService()
              .deleteVacation(vacation, user.availableVacationDays);
        }
        break;
      case ongoingStatus:
        if (endDateToNow < 0) {
          await VacationService()
              .updateVacationStatus(vacation.id, endedStatus, "Ended");
        }
        if (startDateToNow > 0) {
          await VacationService()
              .updateVacationStatus(vacation.id, approvedStatus, "Approved");
        }
        break;
      default:
        break;
    }
  }
}
