import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:vacationapp/shared/colors.dart';
import 'package:vacationapp/widgets/toggle_num_days.dart';
import '../models/user_model.dart';
import '../services/date_service.dart';
import '../services/vacation_service.dart';
import '../shared/data_helper.dart';
import 'days_view.dart';

const minDateDays = 7;
const List<int> weeksInAdvance = [1, 2, 3];
// const List<int> selectableAmount = [2, 5, 10];

List<int> getSelectableAmount(int ad) {
  return [
    if (ad < 2) 1 else 2,
    if (ad <= 5) ad else if (ad > 5) 5,
    if (ad <= 10 && ad > 5) ad else if (ad > 10) 10
  ];
}

DateTime getMidDate(int selectedRange) {
  return DateTime.now()
      .add(Duration(days: (minDateDays * weeksInAdvance[selectedRange])));
}

class VacationDatePicker extends StatefulWidget {
  final bool isAdmin;
  final UserData userData;

  const VacationDatePicker({
    super.key,
    required this.userData,
    required this.isAdmin,
  });

  @override
  State<VacationDatePicker> createState() => _VacationDatePickerState();
}

class _VacationDatePickerState extends State<VacationDatePicker> {
  final DateRangePickerController _datePickerController =
      DateRangePickerController();

  final TextEditingController _descriptionController = TextEditingController();

  int requestedDays = 0;
  String? errorText;
  int selectedRange = 0;

  getNumberOfDays() {
    var selectedRange = _datePickerController.selectedRange;
    if (selectedRange != null &&
        (selectedRange.startDate != null && selectedRange.endDate != null)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          errorText = null;
          requestedDays =
              calculateDays(selectedRange.startDate!, selectedRange.endDate!);
        });
      });
    } else {
      setState(() {
        errorText = "Range must be selected";
      });
    }
  }

  void listenChangesOnDatePicker() {
    if (_datePickerController.selectedRange != null &&
        _datePickerController.selectedRange!.startDate != null &&
        _datePickerController.selectedRange!.endDate != null) {
      getNumberOfDays();
    }
    if (_datePickerController.selectedRange != null &&
        _datePickerController.selectedRange!.startDate != null &&
        _datePickerController.selectedRange!.endDate == null) {
      setState(() {
        requestedDays = 0;
      });
    }
  }

  void handleSelectRange(int selected) {
    _datePickerController.selectedRange = null;
    setState(() {
      selectedRange = selected;
      requestedDays = 0;
    });
  }

  void handleCancel() {
    _datePickerController.selectedRange = null;
    setState(() {
      selectedRange = 0;
      requestedDays = 0;
    });
  }

  void handleCreate(String userId) async {
    if (requestedDays > 0) {
      var startDate = _datePickerController.selectedRange!.startDate!;
      var endDate = _datePickerController.selectedRange!.endDate!;

      await VacationService(uid: userId).createVacation(
          widget.userData.availableVacationDays,
          startDate,
          endDate,
          requestedDays,
          widget.isAdmin);
      // ignore: use_build_context_synchronously
      showSnackBar(context, startDate, endDate, requestedDays);
      if (!widget.isAdmin) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
      } else {
        handleCancel();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Start listening to changes.
    _datePickerController.addPropertyChangedListener((p0) {
      listenChangesOnDatePicker();
    });
  }

  @override
  void dispose() {
    _datePickerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loggedInUser = Provider.of<UserData?>(context);

    final List<int> selectableAmount =
        getSelectableAmount(widget.userData.availableVacationDays);

    final bool check = requestedDays >
        (loggedInUser != null && loggedInUser.isAdmin
            ? widget.userData.availableVacationDays
            : (selectableAmount)[selectedRange]);

    return Column(
      children: [
        if (widget.userData.availableVacationDays > 2 &&
            (loggedInUser == null || (!loggedInUser.isAdmin)))
          ToggleNumDays(
            availableDays: widget.userData.availableVacationDays,
            handleSelectedRange: handleSelectRange,
          ),
        SfDateRangePicker(
          minDate: loggedInUser != null && loggedInUser.isAdmin
              ? DateTime.now()
              : getMidDate(selectedRange),
          enablePastDates: false,
          view: DateRangePickerView.month,
          enableMultiView: true,
          viewSpacing: 20,
          selectionMode: DateRangePickerSelectionMode.range,
          headerStyle:
              const DateRangePickerHeaderStyle(textAlign: TextAlign.center),
          controller: _datePickerController,
        ),
        if (errorText != null)
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              errorText as String,
              style: const TextStyle(color: CustomColors.color4),
            ),
          ),
        DaysView(
          label: "Available vacation days:",
          value: widget.userData.availableVacationDays.toString(),
          background: CustomColors.color5,
          textColor: CustomColors.color1,
        ),
        DaysView(
          label: "Selectable  days:",
          value: loggedInUser != null && loggedInUser.isAdmin
              ? widget.userData.availableVacationDays.toString()
              : selectableAmount[selectedRange].toString(),
          background: CustomColors.color5,
          textColor: CustomColors.color1,
        ),
        DaysView(
          label: "Requested  days:",
          value: requestedDays.toString(),
          background: CustomColors.color5,
          textColor: check ? CustomColors.color4 : CustomColors.color1,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: CustomColors.color1, width: 2.0),
              ),
              labelText: 'Description',
              floatingLabelStyle: TextStyle(color: CustomColors.color1),
            ),
            keyboardType: TextInputType.multiline,
            maxLines: null,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: check ||
                      requestedDays == 0 ||
                      (_datePickerController.selectedRange!.endDate == null)
                  ? null
                  : () {
                      handleCreate(widget.userData.uid);
                    },
              style: ElevatedButton.styleFrom(
                  elevation: 0, backgroundColor: CustomColors.color1),
              child: const Text(
                "Create",
                style: TextStyle(
                  color: CustomColors.color2,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                handleCancel();
              },
              style: ElevatedButton.styleFrom(
                  elevation: 0.0, backgroundColor: CustomColors.color4),
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: CustomColors.color2,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

showSnackBar(context, DateTime startDate, DateTime endDate, int requestedDays) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: CustomColors.color1,
      // backgroundColor: CustomColors.colorAccepted,
      elevation: 0.0,
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
            'Created: ${formatDate(startDate)} / ${formatDate(endDate)} Duration: 2 days'),
      ),
      duration: const Duration(milliseconds: 1500),
      padding: const EdgeInsets.symmetric(
        horizontal: 8.0, // Inner padding for SnackBar content.
      ),
      behavior: SnackBarBehavior.floating,
    ),
  );
}
