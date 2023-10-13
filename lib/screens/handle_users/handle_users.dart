import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacationapp/services/vacation_service.dart';
import 'package:vacationapp/shared/colors.dart';
import 'package:vacationapp/widgets/custom_title.dart';

import '../../models/user_model.dart';
import '../../services/user_service.dart';
import '../../shared/loading.dart';
import 'history_list.dart';

class HandleUserStream extends StatelessWidget {
  const HandleUserStream({super.key});

  @override
  Widget build(BuildContext context) {
    final adminUser = Provider.of<UserData?>(context)!;

    return FutureBuilder(
        future: UserService().fetchAllUsers(),
        builder: (context, AsyncSnapshot<List<UserData?>> snapshot) {
          if (!snapshot.hasData) return const Loading();
          var users = snapshot.data!;
          return HandleUser(adminUser: adminUser, users: users);
        });
  }
}

class HandleUser extends StatefulWidget {
  final UserData adminUser;
  final List<UserData?> users;
  const HandleUser({super.key, required this.users, required this.adminUser});

  @override
  State<HandleUser> createState() => _HandleUserState();
}

class _HandleUserState extends State<HandleUser> {
  String? selectedUserId;
  List<UserData?> localUserData = [];
  List<String> updatedUserIds = [];

  @override
  void initState() {
    super.initState();
    selectedUserId = widget.adminUser.uid;
    localUserData = deepCopyUsers(widget.users);
  }

  @override
  didUpdateWidget(HandleUser oldWidget) {
    super.didUpdateWidget(oldWidget);
    localUserData = widget.users;
  }

  void handleSelectUserData(String uid) {
    setState(() {
      selectedUserId = uid;
    });
  }

  void handleChangeVacationDays(String uid, int availableDays) {
    var userMain = widget.users.where((user) => user!.uid == uid).first!;
    var user = localUserData.where((user) => user!.uid == uid).first!;

    if (availableDays >= 0 && availableDays <= 20) {
      user.availableVacationDays = availableDays;
    }

    setState(() {
      if (userMain.availableVacationDays != user.availableVacationDays &&
          !updatedUserIds.contains(uid)) {
        updatedUserIds.add(uid);
      } else if (userMain.availableVacationDays == user.availableVacationDays &&
          updatedUserIds.contains(uid)) {
        updatedUserIds.removeWhere((id) => id == uid);
      }
    });
  }

  void handleCancel() {
    setState(() {
      localUserData = deepCopyUsers(widget.users);
      updatedUserIds = [];
    });
  }

  void updateVacationDays() {
    for (var userId in updatedUserIds) {
      var user = localUserData.where((user) => user!.uid == userId).firstOrNull;
      if (user != null) {
        UserService(uid: userId)
            .updateUserVacationDays(user.availableVacationDays);
      }
    }
    setState(() {
      updatedUserIds = [];
    });
  }

  void refreshState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // UserData? selectedUser;
    // if (localUserData.isNotEmpty) {
    var selectedUser =
        localUserData.where((user) => user!.uid == selectedUserId).first!;
    // }

    return Scaffold(
      body: Column(
        children: [
          const CustomTitle(title: "Manage user vacations/days"),
          Expanded(
            flex: 1,
            child: ListView(
              children: localUserData
                  .map((e) => ListTileUser(
                        selected: selectedUserId == e!.uid,
                        userData: e,
                        handleSelectUserData: handleSelectUserData,
                        handleChangeVacationDays: handleChangeVacationDays,
                      ))
                  .toList(),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: CustomColors.color1, // Background color
                  ),
                  onPressed: updatedUserIds.isEmpty
                      ? null
                      : () {
                          updateVacationDays();
                        },
                  child: const Text('Save changes'),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 120,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0.0,
                    backgroundColor: CustomColors.color1, // Background color
                  ),
                  onPressed: updatedUserIds.isEmpty ? null : handleCancel,
                  child: const Text('Reset'),
                ),
              ),
            ],
          ),
          const Divider(thickness: 1),
          Expanded(
            flex: 1,
            child: HistoryList(
              user: selectedUser,
              refresh: refreshState,
            ),
          )
        ],
      ),
    );
  }
}

class ListTileUser extends StatefulWidget {
  final Function handleSelectUserData;
  final Function handleChangeVacationDays;
  final UserData userData;
  final bool selected;

  const ListTileUser(
      {super.key,
      required this.userData,
      required this.handleSelectUserData,
      required this.selected,
      required this.handleChangeVacationDays});

  @override
  State<ListTileUser> createState() => _ListTileUserState();
}

class _ListTileUserState extends State<ListTileUser> {
  // int _itemCount = 0;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      tileColor: widget.selected ? CustomColors.color6 : null,
      onTap: () {
        widget.handleSelectUserData(widget.userData.uid);
      },
      title: Row(
        children: [
          Text(
            "${widget.userData.firstName} ${widget.userData.lastName}",
            style:
                TextStyle(color: widget.selected ? Colors.white : Colors.black),
          ),
          FutureBuilder(
            future: VacationService(uid: widget.userData.uid).checkHasPending(),
            builder: (context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.hasData && snapshot.data!) {
                return const Icon(
                  Icons.notifications,
                  color: CustomColors.color4,
                );
              }

              return const SizedBox();
            },
          )
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            // color: Colors.red,
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: CustomColors.color1),
            child: Row(
              children: [
                InkWell(
                    onTap: () {
                      widget.handleChangeVacationDays(widget.userData.uid,
                          widget.userData.availableVacationDays - 1);
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Colors.white,
                      size: 16,
                    )),
                Container(
                  height: 25,
                  alignment: Alignment.center,
                  width: 25,
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.white),
                  child: Text(
                    widget.userData.availableVacationDays.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
                InkWell(
                  onTap: () {
                    widget.handleChangeVacationDays(widget.userData.uid,
                        widget.userData.availableVacationDays + 1);
                  },
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

List<UserData> deepCopyUsers(List<UserData?> userData) {
  var maps = userData.map((e) {
    return e!.convertToJson();
  }).toList();
  var usersData = maps.map((e) => UserData.fromMap(e)).toList();
  return usersData;
}
