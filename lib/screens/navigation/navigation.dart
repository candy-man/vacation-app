import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacationapp/shared/loading.dart';
import '../../models/user_model.dart';
import '../../services/auth.dart';
import '../../shared/colors.dart';
import '../../widgets/vacation_bottom_sheet.dart';
import '../create_request/create_request.dart';
import '../handle_users/handle_users.dart';
import '../calendar/calendar.dart';
import '../home/home.dart';

import 'package:vacationapp/services/user_service.dart';

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final AuthService _auth = AuthService();
  final List<Widget> _screens = [
    const Home(),
    const Clendar(),
    const CreteRequestStream(),
    const HandleUserStream()
  ];
  //states
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<UserData?>(context);
    if (userData == null) return const Loading();
    return Scaffold(
      // backgroundColor: CustomColors.color1,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: userData.isAdmin
            ? Container(
                padding: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: CustomColors.color2)),
                child: const Text("ADMIN"))
            : null,
        backgroundColor: CustomColors.color1,
        elevation: 0.0,
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
            },
            icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: _screens[_selectedIndex],
      floatingActionButtonLocation:
          !userData.isAdmin ? FloatingActionButtonLocation.centerDocked : null,
      floatingActionButton: !userData.isAdmin
          ? FloatingActionButton(
              heroTag: "btn1",
              backgroundColor: CustomColors.color2,
              elevation: 3.0,
              onPressed: () => {
                vacationMainBottomSheet(context, userData),
              },
              tooltip: "Create vacation request",
              child: const Icon(
                Icons.add,
                color: CustomColors.color1,
              ),
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        height: 50.0,
        shape: !userData.isAdmin ? const CircularNotchedRectangle() : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              },
              icon: Icon(
                Icons.home,
                color:
                    _selectedIndex == 0 ? CustomColors.color1 : Colors.black45,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
              icon: Icon(
                Icons.calendar_month,
                color:
                    _selectedIndex == 1 ? CustomColors.color1 : Colors.black45,
              ),
            ),
            if (userData.isAdmin)
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
                icon: Icon(
                  Icons.add_circle_outline_rounded,
                  color: _selectedIndex == 2
                      ? CustomColors.color1
                      : Colors.black45,
                ),
              ),
            if (userData.isAdmin)
              IconButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
                icon: Icon(
                  Icons.manage_accounts,
                  color: _selectedIndex == 3
                      ? CustomColors.color1
                      : Colors.black45,
                ),
              ),
            // if (!userData.isAdmin)
            //   IconButton(
            //     onPressed: () {
            //       setState(() {
            //         _selectedIndex = 2;
            //       });
            //     },
            //     icon: Icon(
            //       Icons.history,
            //       color: _selectedIndex == 2
            //           ? CustomColors.color1
            //           : Colors.black45,
            //     ),
            //   ),
          ],
        ),
      ),
    );
  }
}
