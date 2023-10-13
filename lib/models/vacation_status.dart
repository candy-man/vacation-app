class VacationStatus {
  final int id;
  final String statusName;

  const VacationStatus({required this.id, required this.statusName});

  factory VacationStatus.fromMap(Map data) {
    return VacationStatus(
      id: data['id'] as int,
      statusName: data['statusName'] as String,
    );
  }

  factory VacationStatus.fromJson(Map<String, dynamic> json) {
    return VacationStatus(
        id: json['id'] as int, statusName: json['statusName'] as String);
  }

  Map<String, dynamic> convertToJson() {
    return {
      "id": id,
      "statusName": statusName,
    };
  }
}
