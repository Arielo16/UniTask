class ReportByFolio {
  final String folio;
  final int buildingID;
  final String buildingName;
  final int roomID;
  final String roomName;
  final String roomKey;
  final int typeID;
  final String typeName;
  final int categoryID;
  final String categoryName;
  final int goodID;
  final String goodName;
  final String priority;
  final String description;
  final String? image;
  final int userID;
  final String userName;
  final String userLastname;
  final int statusID;
  final String statusName;
  final int requiresApproval;
  final int involveThirdParties;
  final String createdAt;

  ReportByFolio({
    required this.folio,
    required this.buildingID,
    required this.buildingName,
    required this.roomID,
    required this.roomName,
    required this.roomKey,
    required this.typeID,
    required this.typeName,
    required this.categoryID,
    required this.categoryName,
    required this.goodID,
    required this.goodName,
    required this.priority,
    required this.description,
    this.image,
    required this.userID,
    required this.userName,
    required this.userLastname,
    required this.statusID,
    required this.statusName,
    required this.requiresApproval,
    required this.involveThirdParties,
    required this.createdAt,
  });

  factory ReportByFolio.fromJson(Map<String, dynamic> json) {
    return ReportByFolio(
      folio: json['folio'],
      buildingID: json['buildingID'],
      buildingName: json['building_name'],
      roomID: json['roomID'],
      roomName: json['room_name'],
      roomKey: json['room_key'],
      typeID: json['typeID'],
      typeName: json['type_name'],
      categoryID: json['categoryID'],
      categoryName: json['category_name'],
      goodID: json['goodID'],
      goodName: json['good_name'],
      priority: json['priority'],
      description: json['description'],
      image: json['image'],
      userID: json['userID'],
      userName: json['user_name'],
      userLastname: json['user_lastname'],
      statusID: json['statusID'],
      statusName: json['status_name'],
      requiresApproval: json['requires_approval'],
      involveThirdParties: json['involve_third_parties'],
      createdAt: json['created_at'],
    );
  }
}
