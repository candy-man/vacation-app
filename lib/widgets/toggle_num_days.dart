import 'package:flutter/material.dart';
import 'package:vacationapp/shared/colors.dart';

List<Widget> getVacationRanges(int availableDays) {
  if (availableDays <= 10 && availableDays > 5) {
    return [const Text('1-2'), const Text('<5'), Text('<$availableDays')];
  } else if (availableDays <= 5 && availableDays > 2) {
    return [const Text('1-2'), Text('<$availableDays')];
  }
  return [const Text('1-2'), const Text('<5'), const Text('<10')];
}

List<bool> getRanges(int availableDays) {
  if (availableDays <= 5 && availableDays > 2) return [true, false];
  return [true, false, false];
}

class ToggleNumDays extends StatefulWidget {
  final int availableDays;
  final Function handleSelectedRange;

  const ToggleNumDays(
      {super.key,
      required this.handleSelectedRange,
      required this.availableDays});

  @override
  State<ToggleNumDays> createState() => _ToggleNumDaysState();
}

class _ToggleNumDaysState extends State<ToggleNumDays> {
  List<bool> selectedRanges = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      selectedRanges = getRanges(widget.availableDays);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        ToggleButtons(
          direction: Axis.horizontal,
          onPressed: (int index) {
            print(index);
            setState(() {
              for (int i = 0; i < selectedRanges.length; i++) {
                selectedRanges[i] = i == index;
              }
            });
            widget.handleSelectedRange(index);
          },
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          selectedBorderColor: CustomColors.color1,
          selectedColor: Colors.white,
          fillColor: CustomColors.color6,
          color: CustomColors.color7,
          constraints: const BoxConstraints(
            minHeight: 40.0,
            minWidth: 80.0,
          ),
          isSelected: selectedRanges,
          children: getVacationRanges(widget.availableDays),
        ),
      ],
    );
  }
}
