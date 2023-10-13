// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: dead_code

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firedart/firestore/firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:vacationapp/services/user_service.dart';
import 'package:vacationapp/shared/constants.dart';
import '../models/vacation.dart';
import '../shared/data_helper.dart';

// var usersCollection = Firestore.instance.collection('vacation_requests');

class VacationService {
  final String? uid;
  VacationService({this.uid});

  //POST/PUT
  Future createVacation(
    int availableDays,
    DateTime startDate,
    DateTime endDate,
    int numberOfDays,
    bool isAdmin,
  ) async {
    try {
      if (kIsWeb) {
        var vacationCollection =
            FirebaseFirestore.instance.collection('vacation_requests');
        await vacationCollection.add(
          {
            'startDate': formatDate(startDate),
            'endDate': formatDate(endDate),
            'duration': numberOfDays,
            'userId': uid,
            if (!isAdmin)
              'vacationStatus': {
                'id': 4,
                'statusName': 'Pending',
              }
            else if (calculateDifference(startDate) == 0)
              'vacationStatus': {
                'id': 2,
                'statusName': 'Ongoing',
              }
            else
              'vacationStatus': {
                'id': 1,
                'statusName': 'Approved',
              }
          },
        );
      } else {
        var vacationCollection =
            Firestore.instance.collection('vacation_requests');
        await vacationCollection.add(
          {
            'startDate': formatDate(startDate),
            'endDate': formatDate(endDate),
            'duration': numberOfDays,
            'userId': uid,
            if (!isAdmin)
              'vacationStatus': {
                'id': 4,
                'statusName': 'Pending',
              }
            else if (calculateDifference(startDate) == 0)
              'vacationStatus': {
                'id': 2,
                'statusName': 'Ongoing',
              }
            else
              'vacationStatus': {
                'id': 1,
                'statusName': 'Approved',
              }
          },
        );
      }
      //
      await UserService(uid: uid)
          .updateUserVacationDays(availableDays - numberOfDays);
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  Future deleteVacation(Vacation vacation, int availableDays) async {
    try {
      if (kIsWeb) {
        var vacationCollection =
            FirebaseFirestore.instance.collection('vacation_requests');
        await vacationCollection.doc(vacation.id).delete();
      } else {
        var vacationCollection =
            Firestore.instance.collection('vacation_requests');
        await vacationCollection.document(vacation.id).delete();
      }
      await UserService(uid: vacation.userId)
          .updateUserVacationDays(availableDays + vacation.duration);
    } catch (e) {
      print(e.toString());
    }
  }

  Future updateVacationStatus(
      String vacationId, int statusId, String statusName) async {
    try {
      if (kIsWeb) {
        var vacationCollection =
            FirebaseFirestore.instance.collection('vacation_requests');
        await vacationCollection.doc(vacationId).update({
          'vacationStatus': {
            'id': statusId,
            'statusName': statusName,
          }
        });
      } else {
        var vacationCollection =
            Firestore.instance.collection('vacation_requests');
        await vacationCollection.document(vacationId).update({
          'vacationStatus': {
            'id': statusId,
            'statusName': statusName,
          }
        });
      }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }
  }

  //STEAMS
  Stream<List<Vacation>> get vacations {
    if (kIsWeb) {
      var vacationCollection = FirebaseFirestore.instance
          .collection('vacation_requests')
          .where('userId', isEqualTo: uid)
          .snapshots();
      var res = vacationCollection.map((event) {
        return event.docs.map((e) {
          var data = e.data();
          return Vacation.fromJsonFirebase(e.id, data);
        }).toList();
      });
      return res;
    }

    var vacationCollection = Firestore.instance.collection('vacation_requests');
    var vacationsStream = vacationCollection.stream;
    var res = vacationsStream.map((event) {
      return event
          .map((e) {
            return Vacation.fromJsonFirebase(e.id, e.map);
          })
          .where((e) => e.userId == uid)
          .toList();
    });
    return res;
    // .where('userId', isEqualTo: uid).toJS
    // var res = vacationsStream.map((snapShot) => snapShot.docs
    //     .map((doc) => Vacation.fromJsonFirebase(
    //         doc.id, doc.data() as Map<String, dynamic>))
    //     .toList());
    // return res;
  }

  Future<List<Vacation>> vacationsAll() async {
    if (kIsWeb) {
      var vacationCollection =
          FirebaseFirestore.instance.collection('vacation_requests');
      var shot = await vacationCollection.get();
      return shot.docs.map((e) {
        return Vacation.fromJsonFirebase(e.id, e.data());
      }).toList();
    }
    var vacationCollection = Firestore.instance.collection('vacation_requests');
    var vacationsStream = await vacationCollection.get();
    return vacationsStream.map((e) {
      return Vacation.fromJsonFirebase(e.id, e.map);
    }).toList();
  }

  //GET ALL VACATIONS - needed for status check
  Future<List<Vacation>> fetchAllVacationStatusChecks() async {
    // final CollectionReference vacationCollection =
    //     FirebaseFirestore.instance.collection('vacation_requests');
    // var ref = await Firestore.instance
    //     .collection('vacation_requests')
    //     .where('vacationStatus.id', isEqualTo: endedStatus)
    //     .get();
    if (kIsWeb) {
      var vacationCollection = FirebaseFirestore.instance
          .collection('vacation_requests')
          .where('vacationStatus.id', isNotEqualTo: endedStatus);
      var ref = await vacationCollection.get();
      return ref.docs
          .map((doc) => Vacation.fromJsonFirebase(doc.id, doc.data()))
          .toList();
    }
    var vacationCollection = Firestore.instance.collection('vacation_requests');
    var ref = await vacationCollection.get();
    var vacations =
        ref.map((doc) => Vacation.fromJsonFirebase(doc.id, doc.map));
    return vacations
        .where((element) => element.vacationStatus.id != endedStatus)
        .toList();
    // .where('vacationStatus.id', isNotEqualTo: endedStatus)
    // var documents = snapshot.docs
    //     .map((doc) => Vacation.fromJsonFirebase(
    //         doc.id, doc.data() as Map<String, dynamic>))
    //     .toList();
    // return documents;
  }

  Future<bool> checkHasPending() async {
    if (kIsWeb) {
      var snapshot = await FirebaseFirestore.instance
          .collection('vacation_requests')
          .where('userId', isEqualTo: uid)
          .where('vacationStatus.id', isEqualTo: pendingStatus)
          .get();

      return snapshot.docs.isNotEmpty;
    }
    var vacationCollection = Firestore.instance.collection('vacation_requests');
    var snapshot = await vacationCollection
        .where('userId', isEqualTo: uid)
        .where('vacationStatus.id', isEqualTo: pendingStatus)
        .get();
    return snapshot.isNotEmpty;
  }
}
