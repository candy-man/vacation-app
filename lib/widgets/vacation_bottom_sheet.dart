import 'package:flutter/material.dart';
import 'package:vacationapp/models/user_model.dart';
import 'package:vacationapp/widgets/vacation_date_picker.dart';
import '../shared/colors.dart';

vacationMainBottomSheet(BuildContext context, UserData userData) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
          onTap: () {},
          child: DraggableScrollableSheet(
            initialChildSize: 0.75,
            minChildSize: 0.4,
            maxChildSize: 0.75,
            builder: (_, controller) {
              return Container(
                decoration: const BoxDecoration(
                  color: CustomColors.color5,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  children: [
                    Icon(
                      Icons.remove,
                      color: Colors.grey[600],
                    ),
                    Expanded(
                      child: Scaffold(
                        body: ListView(
                          controller: controller,
                          shrinkWrap: true,
                          children: [
                            VacationDatePicker(
                              isAdmin: false,
                              userData: userData,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
