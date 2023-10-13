import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserService {
  final String? uid;
  UserService({this.uid});

  //collection reference
  // final usersCollection = Firestore.instance.collection('users');

  //GET ONE USERDATA
  Future<UserData> getUserById() async {
    late Map<String, dynamic> data;
    late String id;
    if (kIsWeb) {
      var usersCollection = FirebaseFirestore.instance.collection('users');
      var document = await usersCollection.doc(uid!).get();
      data = document.data()!;
      id = document.id;
    } else {
      var usersCollection = Firestore.instance.collection('users');
      var document = await usersCollection.document(uid!).get();
      data = document.map;
      id = document.id;
    }

    var res = UserData(
        uid: id,
        firstName: data['firstName'] ?? '',
        lastName: data['lastName'] ?? '',
        availableVacationDays: data['availableVacationDays'] ?? 0,
        spentVacationDays: data['spentVacationDays'] ?? 0,
        isAdmin: data['isAdmin'] ?? false);
    return res;
  }

  //setting data
  Future updateUserData(String firstName, String lastName) async {
    try {
      if (kIsWeb) {
        var usersCollection = FirebaseFirestore.instance.collection('users');
        return await usersCollection.doc(uid!).set({
          'firstName': firstName,
          'lastName': lastName,
          'availableVacationDays': 20,
          "spentVacationDays": 0,
          "isAdmin": false
        });
      }
      var usersCollection = Firestore.instance.collection('users');
      return await usersCollection.document(uid!).set({
        'firstName': firstName,
        'lastName': lastName,
        'availableVacationDays': 20,
        "spentVacationDays": 0,
        "isAdmin": false
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future updateUserVacationDays(int vacationDays) async {
    try {
      if (kIsWeb) {
        var usersCollection = FirebaseFirestore.instance.collection('users');
        return await usersCollection.doc(uid!).update({
          'availableVacationDays': vacationDays,
        });
      }
      var usersCollection = Firestore.instance.collection('users');
      await usersCollection.document(uid!).update({
        'availableVacationDays': vacationDays,
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future updateSpentDays(int spentDays) async {
    try {
      if (kIsWeb) {
        var usersCollection = FirebaseFirestore.instance.collection('users');
        return await usersCollection.doc(uid!).update({
          'spentVacationDays': spentDays,
        });
      }
      var usersCollection = Firestore.instance.collection('users');
      return await usersCollection.document(uid!).update({
        'spentVacationDays': spentDays,
      });
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(Map<String, dynamic> data) {
    // var data = document.data()!;
    var res = UserData(
      uid: uid!,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      availableVacationDays: data['availableVacationDays'] ?? '',
      spentVacationDays: data['spentVacationDays'] ?? '',
      isAdmin: data['isAdmin'] ?? false,
    );
    return res;
  }

  Stream<UserData?> get userData {
    // var doc = await Firestore.instance.collection('users').document(uid!).get();
    // return _userDataFromSnapshot(doc.map);
    if (kIsWeb) {
      var res = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots()
          .map((document) {
        return _userDataFromSnapshot(document.data()!);
      });
      return res;
    }

    var ref = Firestore.instance.collection('users').document(uid!).stream;
    var res = ref.map((d) {
      return _userDataFromSnapshot(d!.map);
    });
    return res;
  }

  // List<UserData> _userDataFromSnapshots(
  //     QuerySnapshot<Map<String, dynamic>> snapshot) {
  //   var res = snapshot.docs.map((doc) {
  //     var userData = _userDataFromSnapshot(doc);
  //     return userData;
  //   }).toList();
  //   return res;
  // }
  Stream<List<UserData?>> get allUsersData {
    if (kIsWeb) {
      var res =
          FirebaseFirestore.instance.collection('users').snapshots().map((qs) {
        var d = qs.docs.map((e) {
          return _userDataFromSnapshot(e.data());
        }).toList();
        return d;
      });
      return res;
    }
    var usersCollection = Firestore.instance.collection('users');
    var vacationsStream = usersCollection.stream;
    var res = vacationsStream.map((snapshot) => snapshot
        .map((doc) => UserData.fromJsonFirebase(doc.id, doc.map))
        .toList());
    return res;
  }

  //GET ALL USERS FETCH - needed for status check
  Future<List<UserData>> fetchAllUsers() async {
    if (kIsWeb) {
      var qs = await FirebaseFirestore.instance.collection('users').get();

      var users = qs.docs.map((doc) {
        return UserData.fromJsonFirebase(doc.id, doc.data());
      }).toList();
      return users;
    }

    var ref = await Firestore.instance.collection('users').get();
    var users =
        ref.map((doc) => UserData.fromJsonFirebase(doc.id, doc.map)).toList();
    return users;
  }
}
