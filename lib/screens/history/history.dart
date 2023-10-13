import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacationapp/models/vacation.dart';
import 'package:vacationapp/widgets/vacation_details.dart';
import 'package:vacationapp/shared/loading.dart';
import 'package:vacationapp/widgets/custom_title.dart';
import '../../models/user_model.dart';
import '../../services/vacation_service.dart';
import '../../shared/colors.dart';
import '../../shared/data_helper.dart';
import '../../widgets/delete_vacation.dart';

class History extends StatelessWidget {
  final UserData userData;
  const History({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel?>(context);
    // final userData = Provider.of<UserData?>(context)!;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.color1,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const CustomTitle(title: "Vacation history"),
          Expanded(
            child: StreamBuilder<List<Vacation>>(
              stream: VacationService(uid: user!.uid).vacations,
              builder: (context, AsyncSnapshot<List<Vacation>> snapshot) {
                if (snapshot.hasData) {
                  var vacations = snapshot.data!;
                  vacations.sort((a, b) => b.startDate.compareTo(a.startDate));

                  if (vacations.isEmpty) {
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("No vacations"),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: 25),
                    itemCount: vacations.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        color: CustomColors.color2,
                        child: ListTile(
                          trailing: vacations[index].vacationStatus.id == 4
                              ? IconButton(
                                  onPressed: () {
                                    deleteVacation(
                                        context, vacations[index], userData);
                                  },
                                  icon: const Icon(
                                    Icons.delete_forever,
                                    color: Colors.red,
                                  ))
                              : null,
                          onTap: () {
                            vacationDetails(context, vacations[index]);
                          },
                          title: Text(
                              "Vacation ${formatDate(vacations[index].startDate)} / ${formatDate(vacations[index].endDate)} "),
                          subtitle: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5.0),
                                decoration: getStatusColor(
                                    vacations[index].vacationStatus.id),
                                child: Text(
                                  "${vacations[index].vacationStatus.statusName}: ${vacations[index].duration} days",
                                  style: const TextStyle(
                                      color: CustomColors.color2),
                                ),
                              ),
                            ],
                          ),
                          // vacations[index].vacationStatus.statusName
                        ),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  );
                }
                return const Loading();
              },
            ),
          ),
        ],
      ),
    );
  }
}
