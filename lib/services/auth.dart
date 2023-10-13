// ignore_for_file: avoid_print
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:firedart/auth/user_gateway.dart';
import 'package:vacationapp/models/user_model.dart';
import 'package:vacationapp/services/user_service.dart';
import 'package:firedart/firedart.dart';
import 'package:firedart/auth/exceptions.dart';
import 'package:firedart/firedart.dart';

const apiKey = 'AIzaSyABJUXPK5NDHNRJnJTBFjo9KpCT3-WVBtE';
const projectId = 'vacation-app-f1367';

class AuthService {
  var auth = FirebaseAuth.instance;
  // late FirebaseAuth auth = FirebaseAuth(apiKey, tokenStore);

  //create user obj based on firebase user
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.id, email: user.email!) : null;
  }

  //auth change user stream
  // Stream<UserModel?> get user {
  //   auth.signInState.listen((state) => print("Signed ${state ? "in" : "out"}"));
  //   var res = auth.authStateChanges();
  //   return res.map(_userFromFirebaseUser);
  //   // .map((User? user) => _userFromFirebaseUser(user));
  // }

  // Future<UserModel?> signInAnon() async {
  //   try {
  //     UserCredential result = await _auth.signInAnonymously();
  //     var user = result.user;
  //     return _userFromFirebaseUser(user);
  //   } on FirebaseAuthException catch (e) {
  //     switch (e.code) {
  //       case "operation-not-allowed":
  //         print("Anonymous auth hasn't been enabled for this project.");
  //         break;
  //       default:
  //         print("Unknown error.");
  //     }
  //     return null;
  //   }
  // }

  Future<UserModel?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      print(email);
      print(password);
      await auth.signIn(email, password);
      var user = await auth.getUser();
      // UserCredential result = await _auth.signInWithEmailAndPassword(
      //     email: email, password: password);
      // var user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  Future<UserModel?> registerWithEamilAndPassword(
      String email, String password, String userName, String lastName) async {
    try {
      var result = await auth.signIn(email, password);
      var user = result;
      if (user != null) {
        await UserService(uid: user.id).updateUserData(userName, lastName);
      }
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  void signOut() async {
    try {
      auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
