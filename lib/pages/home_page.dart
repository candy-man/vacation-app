import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:vacationapp/shared/colors.dart';
import '../services/auth.dart';
import '../widgets/calendar_custom.dart';
import '../widgets/custom_text.dart';
import '../widgets/vacation_bottom_sheet.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final AuthService _auth = AuthService();
  // final ref = FirebaseDatabase.instance.ref();
  // final DatabaseReference ref =
  //     FirebaseDatabase.instance.ref('vacation_requests');

  // ref.onValue.listen((DatabaseEvent event) {
  //   final data = event.snapshot.value;
  //   updateStarCount(data);
  //   });

  // void GetData() {

  // }

  final List<Widget> _screens = [
    Container(
      color: Colors.yellow.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Home',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.blue.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Feed',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.red.shade100,
      alignment: Alignment.center,
      child: const Text(
        'Favorites',
        style: TextStyle(fontSize: 40),
      ),
    ),
    Container(
      color: Colors.yellow.shade500,
      alignment: Alignment.center,
      child: const Text(
        'Settings',
        style: TextStyle(fontSize: 40),
      ),
    ),
  ];

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0;
  // BorderRadiusGeometry radius = BorderRadius.only(
  //   topLeft: Radius.circular(24.0),
  //   topRight: Radius.circular(24.0),
  // );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.color2,
      appBar: AppBar(
        backgroundColor: CustomColors.color1,
        actions: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
        ],
        elevation: 0,
      ),
      // body: const Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Expanded(
      //       child: CalendarCustom(),
      //     ),
      //     VacationDaysStatus()
      //   ],
      // ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: CustomColors.color1,
      //   onPressed: () => vacationMainBottomSheet(context),
      //   elevation: 0,
      //   child: const Icon(Icons.create),
      // ),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              selectedLabelTextStyle: const TextStyle(
                color: Colors.teal,
              ),
              destinations: const [
                NavigationRailDestination(
                    icon: Icon(Icons.home), label: Text('Home')),
                NavigationRailDestination(
                    icon: Icon(Icons.feed), label: Text('Feed')),
                NavigationRailDestination(
                    icon: Icon(Icons.favorite), label: Text('Favorites')),
                NavigationRailDestination(
                    icon: Icon(Icons.settings), label: Text('Settings')),
              ],
              selectedIndex: _selectedIndex,
              onDestinationSelected: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              leading: const Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  CircleAvatar(
                    radius: 20,
                    child: Icon(Icons.person),
                  )
                ],
              ),
            ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? BottomNavigationBar(
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.indigoAccent,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite), label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings), label: 'Settings'),
              ],
            )
          : null,
    );
  }
}
//  Center(
//           child: Text(
//         "LOGGED IN AS: ${user.email!}",
//         style: const TextStyle(fontSize: 20),
//       )),
