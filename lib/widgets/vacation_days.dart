import 'package:flutter/material.dart';

import '../shared/colors.dart';

class Days extends StatelessWidget {
  final int? statusId;
  final String status;
  final int days;
  const Days(
      {super.key, this.statusId, required this.status, required this.days});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        padding: const EdgeInsets.fromLTRB(5, 10, 5, 7),
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        color: statusId == null
            ? CustomColors.color1
            : statusId == 0
                ? CustomColors.colorAccepted
                : CustomColors.color4,
        alignment: Alignment.center,
        child: Text(
          status,
          style: const TextStyle(
            color: CustomColors.color2,
            fontSize: 20,
          ),
        ),
      ),
      Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: Border.all(
          color: statusId == null
              ? CustomColors.color1
              : statusId == 0
                  ? CustomColors.colorAccepted
                  : CustomColors.color4,
        )),
        child: Text(
          days.toString(),
          style: TextStyle(
            color: statusId == null
                ? CustomColors.color1
                : statusId == 0
                    ? CustomColors.colorAccepted
                    : CustomColors.color4,
            fontSize: 20,
          ),
        ),
      )
    ]);
  }
}
