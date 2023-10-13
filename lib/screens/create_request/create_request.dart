import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacationapp/models/user_model.dart';
import 'package:vacationapp/shared/loading.dart';
import '../../services/user_service.dart';
import '../../shared/colors.dart';
import '../../widgets/custom_title.dart';
import '../../widgets/vacation_date_picker.dart';

class CreteRequestStream extends StatelessWidget {
  const CreteRequestStream({super.key});

  @override
  Widget build(BuildContext context) {
    final adminUser = Provider.of<UserData?>(context)!;
    return FutureBuilder(
        future: UserService().fetchAllUsers(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Loading();
          var users = snapshot.data!;
          // return Placeholder();
          return CreateRequest(
            adminUser: adminUser,
            users: users,
          );
        });
  }
}

class CreateRequest extends StatefulWidget {
  final UserData adminUser;
  final List<UserData?> users;
  const CreateRequest(
      {super.key, required this.adminUser, required this.users});

  @override
  State<CreateRequest> createState() => _CreateRequestState();
}

class _CreateRequestState extends State<CreateRequest> {
  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    // dropdownValue = adminUser.uid;

    var selectedUser = (dropdownValue == null
        ? widget.users[0]
        : widget.users.where((e) => e!.uid == dropdownValue).first!)!;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomTitle(title: "Create for:"),
            DropdownButton(
              onChanged: (String? value) {
                // This is called when the user selects an item.
                setState(() {
                  dropdownValue = value!;
                });
              },
              elevation: 1,
              style: const TextStyle(fontSize: 16.0),
              value: dropdownValue ?? widget.adminUser.uid,
              underline: null,
              isExpanded: true,
              items:
                  widget.users.map<DropdownMenuItem<String>>((UserData? value) {
                return DropdownMenuItem<String>(
                  value: value!.uid,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "${value.firstName} ${value.lastName}",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                );
              }).toList(),
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VacationDatePicker(
                  userData: widget.users.firstWhere((element) {
                    var t = element!;
                    return t.uid == (dropdownValue ?? widget.adminUser.uid);
                  })!,
                  isAdmin: true,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

    // return Column(
    //   children: [
    //     const CustomTitle(title: "Create for:"),
    //     DropdownButton<String>(
    //       isExpanded: true,
    //       value: dropdownValue,
    //       // borderRadius: BorderRadius.circular(12),
    //       // icon: const Icon(Icons.arrow_downward),
    //       elevation: 1,
    //       style: const TextStyle(color: Colors.deepPurple),
    //       // underline: Container(
    //       //   height: 2,
    //       //   color: Colors.deepPurpleAccent,
    //       // ),
    //       borderRadius: BorderRadius.all(Radius.circular(2)),
    //       onChanged: (String? value) {
    //         // This is called when the user selects an item.
    //         setState(() {
    //           dropdownValue = value!;
    //         });
    //       },
    //       items: list.map<DropdownMenuItem<String>>((String value) {
    //         return DropdownMenuItem<String>(
    //           value: value,
    //           child: Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Container(
    //               child: Text(
    //                 value,
    //                 // style: TextStyle(color: Colors.white),
    //               ),
    //             ),
    //           ),
    //         );
    //       }).toList(),
    //     ),
    //   ],
    // );

//   Container(
  //     color: Colors.amber,
  //     child: Row(children: [
  //       DropdownMenu<String>(
  //         width: MediaQuery.of(context).size.width,
  //         initialSelection: list.first,
  //         onSelected: (String? value) {
  //           // This is called when the user selects an item.
  //           setState(() {
  //             dropdownValue = value!;
  //           });
  //         },
  //         dropdownMenuEntries:
  //             list.map<DropdownMenuEntry<String>>((String value) {
  //           return DropdownMenuEntry<String>(value: value, label: value);
  //         }).toList(),
  //       )
  //     ]),
  //   );
  // }