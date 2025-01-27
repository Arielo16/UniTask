// lib/models/report.dart
class Report {
  final String folio;
  final String buildingID;
  final String roomID;
  final String categoryID;
  final String goodID;
  final String priority;
  final String description;
  final String image;
  final String userID;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  Report({
    required this.folio,
    required this.buildingID,
    required this.roomID,
    required this.categoryID,
    required this.goodID,
    required this.priority,
    required this.description,
    required this.image,
    required this.userID,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      folio: json['folio'],
      buildingID: json['buildingID'],
      roomID: json['roomID'],
      categoryID: json['categoryID'],
      goodID: json['goodID'],
      priority: json['priority'],
      description: json['description'],
      image: json['image'],
      userID: json['userID'],
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}