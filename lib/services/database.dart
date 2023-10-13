// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:vacationapp/models/user_model.dart';

// import '../models/brew.dart';

// class DatabaseService {
//   final String? uid;
//   DatabaseService({this.uid});

//   //collection reference
//   final CollectionReference brewCollection =
//       FirebaseFirestore.instance.collection('brews');

//   //setting data of brews for user
//   Future updateUserData(String sugars, String name, int strenght) async {
//     try {
//       return await brewCollection.doc(uid).set(
//         {'sugars': sugars, 'name': name, "strenght": strenght},
//       );
//     } catch (e) {
//       print(e.toString());
//     }
//   }

//   //brew list from snapshot
//   List<Brew?> _brewListFromSnapshot(
//       QuerySnapshot<Map<String, dynamic>> snapshot) {
//     var res = snapshot.docs.map((doc) {
//       var data = doc.data();
//       return Brew(
//         name: data['name'] ?? '',
//         sugars: data['sugars'] ?? '',
//         strenght: data['strenght'],
//       );
//     }).toList();
//     return res;
//   }

//   //get brews streams
//   Stream<List<Brew?>> get brews {
//     return brewCollection.snapshots().map((query) {
//       return _brewListFromSnapshot(
//           query as QuerySnapshot<Map<String, dynamic>>);
//     });
//   }

//   //user data from snapshot
//   // UserData _userDataFromSnapshot(
//   //     DocumentSnapshot<Map<String, dynamic>> document) {
//   //   var data = document.data()!;
//   //   var res = UserData(
//   //       uid: uid!,
//   //       sugars: data['sugars'] ?? '',
//   //       strength: data['strenght'] ?? '',
//   //       name: data['name'] ?? '');
//   //   return res;
//   // }

//   // Stream<UserData> get userData {
//   //   return brewCollection.doc(uid).snapshots().map((document) {
//   //     return _userDataFromSnapshot(
//   //         document as DocumentSnapshot<Map<String, dynamic>>);
//   //   });
//   // }
// }
