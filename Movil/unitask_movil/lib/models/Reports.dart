// lib/models/report.dart
class Report {
  final String folio;
  final String buildingID;
  final String roomID;
  final int categoryID;
  final int goodID;
  final String priority;
  final String description;
  final String image;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String matricula;

  Report({
    required this.folio,
    required this.buildingID,
    required this.roomID,
    required this.categoryID,
    required this.goodID,
    required this.priority,
    required this.description,
    required this.image,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.matricula,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      folio: json['folio'] ?? '',
      buildingID: json['buildingID'] ?? '',
      roomID: json['roomID'] ?? '',
      categoryID: json['categoryID'] ?? 0,
      goodID: json['goodID'] ?? 0,
      priority: json['priority'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
      updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : DateTime.now(),
      matricula: json['matricula'] ?? '',
    );
  }
}