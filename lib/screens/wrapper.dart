import 'dart:async';

import 'package:firedart/auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vacationapp/models/user_model.dart';
import 'package:vacationapp/services/user_service.dart';
import '../services/background_tasks.dart';
import 'authenticate/authenticate.dart';
import 'navigation/navigation.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({super.key});

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final auth = FirebaseAuth.instance;
  //state
  bool isLoggedIn = false;

  @override
  void initState() {
    auth.signInState.listen((event) {
      setState(() {
        isLoggedIn = event;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //hvatas user kroz provider (kao redux fora)
    // final user = Provider.of<UserModel?>(context);
    if (!isLoggedIn) {
      return const Authenticate();
    } else {
      // Timer.periodic(
      //   const Duration(seconds: 10),
      //   (Timer t) async => await handleVacationStatuses(),
      // );

      // return const Navigation();

      return StreamProvider<UserData?>.value(
        value: UserService(uid: auth.userId).userData,
        initialData: null,
        child: const Navigation(),
        // stream: UserService(uid: user.uid).userData,
        // builder: (context, snapshot) {
        //   if (snapshot.hasData) {
        //     UserData userData = snapshot.data!;
        //     return Navigation(
        //       userData: userData,
        //     );
        //   } else {
        //     return const Loading();
        //   }
        // });
      );
    }
  }
}


      // return StreamProvider<UserData?>.value(
      //   value: UserService(uid: auth.userId).userData,
      //   initialData: null,
      //   child: const Navigation(),
      //   // stream: UserService(uid: user.uid).userData,
      //   // builder: (context, snapshot) {
      //   //   if (snapshot.hasData) {
      //   //     UserData userData = snapshot.data!;
      //   //     return Navigation(
      //   //       userData: userData,
      //   //     );
      //   //   } else {
      //   //     return const Loading();
      //   //   }
      //   // });