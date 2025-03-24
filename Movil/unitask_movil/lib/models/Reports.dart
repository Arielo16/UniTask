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
  final String id;
  final String status;
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
    required this.id,
    required this.status,
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
      buildingID: json['buildingID'] ?? '',  // Cambiado a String
      roomID: json['roomID'] ?? '',          // Cambiado a String
      categoryID: json['categoryID'] ?? '',  // Cambiado a String
      goodID: json['goodID'] ?? '',          // Cambiado a String
      priority: json['priority'] ?? '',
      description: json['description'] ?? '',
      image: json['image'],
      id: json['id'] ?? '',
      status: json['status'] ?? '',
      requiresApproval: json['requires_approval'] == 1,
      involveThirdParties: json['involve_third_parties'] == 1,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      buildingName: json['buildingID'] ?? '', // Cambiado a String
      roomName: json['roomID'] ?? '',         // Cambiado a String
      categoryName: json['categoryID'] ?? '', // Cambiado a String
      goodName: json['goodID'] ?? '',         // Cambiado a String
      userName: json['id'] ?? '',             // Cambiado a String
      statusName: json['status'] ?? '',       // Cambiado a String
    );
  }
}
