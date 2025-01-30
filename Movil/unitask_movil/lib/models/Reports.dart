// lib/models/report.dart
class Report {
  final String folio;
  final int buildingID;
  final int roomID;
  final int categoryID;
  final int goodID;
  final String priority;
  final String description;
  final String? image;
  final int userID;
  final int statusID;
  final bool requiresApproval;
  final bool involveThirdParties;
  final DateTime createdAt;
  final DateTime updatedAt;

  String? buildingName;
  String? roomName;
  String? categoryName;
  String? goodName;
  String? userName;
  String? statusName;

  Report({
    required this.folio,
    required this.buildingID,
    required this.roomID,
    required this.categoryID,
    required this.goodID,
    required this.priority,
    required this.description,
    this.image,
    required this.userID,
    required this.statusID,
    required this.requiresApproval,
    required this.involveThirdParties,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      folio: json['folio'] ?? '',
      buildingID: json['buildingID'] ?? 0,
      roomID: json['roomID'] ?? 0,
      categoryID: json['categoryID'] ?? 0,
      goodID: json['goodID'] ?? 0,
      priority: json['priority'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      userID: json['userID'] ?? 0,
      statusID: json['statusID'] ?? 0,
      requiresApproval: json['requires_approval'] == 1,
      involveThirdParties: json['involve_third_parties'] == 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
    );
  }
}
