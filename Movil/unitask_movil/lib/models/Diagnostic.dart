class Diagnostic {
  final int diagnosticID;
  final int reportID;
  final String reportFolio;
  final String description;
  final String? images;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> materials; 

  Diagnostic({
    required this.diagnosticID,
    required this.reportID,
    required this.reportFolio,
    required this.description,
    this.images,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.materials,
  });

  factory Diagnostic.fromJson(Map<String, dynamic> json) {
    return Diagnostic(
      diagnosticID: json['diagnosticID'] ?? 0,
      reportID: json['reportID'] ?? 0,
      reportFolio: json['report_folio'] ?? '',
      description: json['description'] ?? '',
      images: json['images'],
      status: json['status'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : DateTime.now(),
      materials: json['materials'] ?? [],
    );
  }
}
