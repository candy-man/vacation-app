import 'package:flutter/material.dart';

import '../shared/colors.dart';

class CustomTitle extends StatelessWidget {
  const CustomTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(5, 10, 5, 7),
      color: CustomColors.color1,
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: CustomColors.color2,
          fontSize: 20,
        ),
      ),
    );
  }
}
