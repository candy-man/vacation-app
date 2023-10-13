import 'package:firebase_core/firebase_core.dart';
import 'package:firedart/auth/firebase_auth.dart';
import 'package:firedart/auth/token_store.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vacationapp/firebase_options.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:vacationapp/screens/wrapper.dart';

const apiKey = 'AIzaSyABJUXPK5NDHNRJnJTBFjo9KpCT3-WVBtE';
const projectId = 'vacation-app-f1367';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } else {
    Firestore.initialize(projectId);
  }
  FirebaseAuth.initialize(apiKey, VolatileStore());
  // Firestore.initialize(projectId);

  // Timer.periodic(
  //   const Duration(seconds: 10),
  //   (Timer t) async => await handleVacationStatuses(),
  // );

  // var cron = Cron();
  // cron.schedule(Schedule.parse('*/1 * * * *'), () async {
  //   await handleVacationStatuses();
  // });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   home: Scaffold(
    //     body: SafeArea(
    //       child: Column(
    //         children: [
    //           ElevatedButton(
    //             child: Text("test"),
    //             onPressed: () async {
    //               CollectionReference ttt =
    //                   FirebaseFirestore.instance.collection('users');

    //               print(ttt);
    //             },
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return MaterialApp(
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const Wrapper(),
    );
  }
}
