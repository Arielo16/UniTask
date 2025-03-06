// lib/models/report.dart
class Report {
  final int reportID;
  final String folio;
  final String buildingID;
  final String roomID;
  final String categoryID;
  final String goodID;
  final String priority;
  final String description;
  final String? image;
  final String userID;
  final int statusID;
  final bool requiresApproval;
  final bool involveThirdParties;
  final DateTime createdAt;
  final DateTime updatedAt;

  String buildingName;
  String roomName;
  String categoryName;
  String goodName;
  String userName;
  String statusName;

  Report({
    required this.reportID,
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
    required this.buildingName,
    required this.roomName,
    required this.categoryName,
    required this.goodName,
    required this.userName,
    required this.statusName,
  });

  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      reportID: json['reportID'] ?? 0,
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
      buildingName: json['buildingID'] as String? ?? '',
      roomName: json['roomID'] as String? ?? '',
      categoryName: json['categoryID'] as String? ?? '',
      goodName: json['goodID'] as String? ?? '',
      userName: json['id'] as String? ?? '',
      statusName: json['status'] as String? ?? '',
    );
  }
}
