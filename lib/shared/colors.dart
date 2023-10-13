import 'package:flutter/material.dart';

class CustomColors {
  static const color1 = Color.fromRGBO(51, 102, 153, 1);
  static const color2 = Color.fromARGB(255, 255, 255, 255);
  static const color3 = Color.fromARGB(140, 255, 255, 255);
  static const color4 = Color.fromRGBO(244, 67, 54, 1);
  static const color5 = Color.fromRGBO(250, 250, 250, 1);
  static const color6 = Color.fromRGBO(51, 102, 153, 0.6);
  static const color7 = Color.fromRGBO(0, 0, 0, 1);

  static const colorEnded = Color.fromRGBO(204, 204, 204, 1);
  static const colorAccepted = Color.fromRGBO(57, 188, 38, 1);
  static const colorOngoing = Color.fromRGBO(124, 77, 255, 1);
}

BoxDecoration getStatusColor(int statusId) {
  switch (statusId) {
    case 1: //Approved
      return const BoxDecoration(
        color: CustomColors.colorAccepted,
      );
    case 2: //Ongoing
      // return const BoxDecoration(
      //   gradient: LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment(0.8, 1),
      //     colors: <Color>[
      //       CustomColors.colorAccepted,
      //       CustomColors.colorEnded,
      //     ],
      //     tileMode: TileMode.mirror,
      //   ),
      // );
      return const BoxDecoration(
        color: CustomColors.colorOngoing,
      );
    case 3: //Ended
      return const BoxDecoration(color: CustomColors.colorEnded);
    case 4: //Pending
    default:
      return const BoxDecoration(
        color: CustomColors.color4,
      );
  }
}
