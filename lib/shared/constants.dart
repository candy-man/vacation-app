import 'package:flutter/material.dart';

import 'colors.dart';

var textInputDecoration = InputDecoration(
  fillColor: Colors.grey.shade100,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.grey.shade100, width: 2.0),
  ),
  focusedBorder: const OutlineInputBorder(
    borderSide: BorderSide(color: CustomColors.color1),
  ),
  filled: true,
  hintStyle: TextStyle(color: Colors.grey.shade500),
);

enum VacationStatusEnum { approved, ongoing, ended, pending }

const approvedStatus = 1;
const ongoingStatus = 2;
const endedStatus = 3;
const pendingStatus = 4;
