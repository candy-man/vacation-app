import 'package:flutter/material.dart';
import 'package:vacationapp/models/user_model.dart';
import 'package:vacationapp/shared/constants.dart';

import '../../models/vacation.dart';
import '../../services/vacation_service.dart';
import '../../shared/colors.dart';
import '../../shared/data_helper.dart';
import '../../shared/loading.dart';
import '../../widgets/approve_vacation.dart';
import '../../widgets/delete_vacation.dart';
import '../../widgets/vacation_details.dart';

class HistoryList extends StatelessWidget {
  final Function refresh;
  final UserData user;
  const HistoryList({super.key, required this.user, required this.refresh});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Vacation>>(
      stream: VacationService(uid: user.uid).vacations,
      builder: (context, AsyncSnapshot<List<Vacation>> snapshot) {
        if (snapshot.hasData) {
          var vacations = snapshot.data!;
          vacations.sort((a, b) => b.startDate.compareTo(a.startDate));

          if (vacations.isEmpty) return const Text("No vacations");

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 25),
            itemCount: vacations.length,
            itemBuilder: (BuildContext itemContext, int index) {
              return Container(
                color: CustomColors.color2,
                child: ListTile(
                  trailing: Wrap(children: [
                    if (vacations[index].vacationStatus.id == pendingStatus)
                      IconButton(
                          onPressed: () {
                            deleteVacation(context, vacations[index], user);
                          },
                          icon: const Icon(
                            Icons.delete_forever,
                            color: Colors.red,
                          )),
                  ]),
                  onTap: () {
                    vacationDetails(context, vacations[index]);
                  },
                  title: Text(
                      "Vacation ${formatDate(vacations[index].startDate)} / ${formatDate(vacations[index].endDate)} "),
                  subtitle: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5.0),
                        decoration:
                            getStatusColor(vacations[index].vacationStatus.id),
                        child: Text(
                          "${vacations[index].vacationStatus.statusName}: ${vacations[index].duration} days",
                          style: const TextStyle(color: CustomColors.color2),
                        ),
                      ),
                      if (vacations[index].vacationStatus.id == pendingStatus)
                        const SizedBox(width: 10),
                      if (vacations[index].vacationStatus.id == pendingStatus)
                        GestureDetector(
                          child: const Icon(
                            Icons.check_sharp,
                            color: CustomColors.colorAccepted,
                          ),
                          onTap: () {
                            approveVacation(
                                context, vacations[index], user, refresh);
                          },
                        ),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(),
          );
        }
        return const Loading();
      },
    );
  }
}
