import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:vacationapp/shared/colors.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: CustomColors.color2,
      child: const Center(
        child: SpinKitCircle(
          color: CustomColors.color1,
          size: 50.0,
        ),
      ),
    );
  }
}
