// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:vacationapp/screens/home_test/brew_list.dart';
// import 'package:vacationapp/screens/home_test/setttings_form.dart';
// import 'package:vacationapp/services/auth.dart';
// import 'package:vacationapp/services/database.dart';

// import '../../models/brew.dart';
// import '../../models/user_model.dart';

// class Home extends StatelessWidget {
//   Home({super.key});

//   final AuthService _auth = AuthService();

//   @override
//   Widget build(BuildContext context) {
//     void _showSettingsPanel() {
//       showModalBottomSheet(
//           context: context,
//           builder: (context) {
//             return Container(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 60.0, vertical: 20.0),
//               child: SettingsForm(),
//             );
//           });
//     }

//     return StreamProvider<List<Brew?>>.value(
//       value: DatabaseService().brews,
//       initialData: const [],
//       child: Scaffold(
//         appBar: AppBar(
//           elevation: 0.0,
//           actions: [
//             IconButton(
//               onPressed: () async {
//                 await _auth.signOut();
//               },
//               icon: const Icon(Icons.logout),
//             ),
//             IconButton(
//                 onPressed: () {
//                   _showSettingsPanel();
//                 },
//                 icon: const Icon(Icons.settings))
//           ],
//         ),
//         body: const BrewList(),
//       ),
//     );
//   }
// }
