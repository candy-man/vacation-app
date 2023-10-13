class UserModel {
  final String uid;
  final String email;

  UserModel({required this.uid, required this.email});
}

class UserRole {
  final String id;
  final String role;

  UserRole({required this.id, required this.role});
}

class UserData {
  String uid;
  String firstName;
  String lastName;
  int availableVacationDays;
  int spentVacationDays;
  bool isAdmin;

  UserData({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.availableVacationDays,
    required this.spentVacationDays,
    required this.isAdmin,
  });

  factory UserData.fromJsonFirebase(String id, Map<String, dynamic> json) {
    return UserData(
        uid: id,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        availableVacationDays: json['availableVacationDays'] as int,
        spentVacationDays: json['spentVacationDays'] as int,
        isAdmin: json['isAdmin'] as bool);
  }

  factory UserData.fromMap(Map<String, dynamic> json) {
    return UserData(
        uid: json['uid'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        availableVacationDays: json['availableVacationDays'] as int,
        spentVacationDays: json['spentVacationDays'] as int,
        isAdmin: json['isAdmin'] as bool);
  }

  Map<String, dynamic> convertToJson() {
    return {
      "uid": uid,
      "firstName": firstName,
      "lastName": lastName,
      "availableVacationDays": availableVacationDays,
      "spentVacationDays": spentVacationDays,
      "isAdmin": isAdmin
    };
  }
}
