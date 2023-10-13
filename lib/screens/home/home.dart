import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacationapp/services/auth.dart';
import 'package:vacationapp/shared/colors.dart';

import '../../models/user_model.dart';
import '../../models/vacation.dart';
import '../../services/vacation_service.dart';
import '../../shared/constants.dart';
import '../../shared/loading.dart';
import '../../widgets/ongoing_days.dart';
import '../../widgets/vacation_days.dart';
import '../history/history.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  // final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context)!;

    return StreamBuilder<List<Vacation>>(
        stream: VacationService(uid: userData.uid).vacations,
        builder: (context, AsyncSnapshot<List<Vacation>> snapshot) {
          if (!snapshot.hasData) return const Loading();

          var vacations = snapshot.data!;
          var ongoingVacation = getVacationBasedOnStatus(
                  vacations, VacationStatusEnum.ongoing.index + 1)
              .firstOrNull;
          var pendingVacations = getVacationBasedOnStatus(
              vacations, VacationStatusEnum.pending.index + 1);
          var approvedVacations = getVacationBasedOnStatus(
              vacations, VacationStatusEnum.approved.index + 1);

          return Scaffold(
            floatingActionButton: !userData.isAdmin
                ? FloatingActionButton(
                    heroTag: "btn2",
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                    backgroundColor: CustomColors.color2,
                    elevation: 3.0,
                    onPressed: () => {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => History(
                                  userData: userData,
                                )),
                      )
                    },
                    tooltip: "Vacation history",
                    child: const Icon(
                      Icons.history,
                      color: CustomColors.color1,
                    ),
                  )
                : null,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  color: CustomColors.color1,
                  child: Column(
                    children: [
                      const Center(
                        child: Text(
                          "User info",
                          style: TextStyle(
                              fontSize: 20.0, color: CustomColors.color2),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            userData.firstName,
                            style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.color2),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            userData.lastName,
                            style: const TextStyle(
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                                color: CustomColors.color2),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: Days(
                        status: "Available days",
                        days: userData.availableVacationDays,
                      ),
                    ),
                    Expanded(
                      child: Days(
                        status: "Spent days",
                        days: userData.spentVacationDays,
                      ),
                    ),
                  ],
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Divider(thickness: 1.0, height: 20.0),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Days(
                        status: 'Approved',
                        statusId: 0,
                        days: approvedVacations.isNotEmpty
                            ? approvedVacations.fold(
                                0, (p, c) => p + c!.duration)
                            : 0,
                      ),
                    ),
                    Expanded(
                      child: Days(
                        status: 'Pending',
                        statusId: 1,
                        days: pendingVacations.isNotEmpty
                            ? pendingVacations.fold(
                                0, (p, c) => p + c!.duration)
                            : 0,
                      ),
                    ),
                  ],
                ),
                if (ongoingVacation != null) SizedBox(height: 100),
                if (ongoingVacation != null)
                  OngoingDays(
                    vacation: ongoingVacation,
                  )
              ],
            ),
          );
        });
  }
}

List<Vacation?> getVacationBasedOnStatus(
    List<Vacation> vacations, int statusId) {
  return vacations.where((e) => e.vacationStatus.id == statusId).toList();
}
