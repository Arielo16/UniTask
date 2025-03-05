// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/Reports.dart';
import '../models/Diagnostic.dart';
import '../models/report_by_folio.dart';
import 'package:flutter/foundation.dart'; // Agregado para kIsWeb

class ApiService {
  // Cambiar la URL base según el entorno
  final String baseUrl =
      kIsWeb ? "http://127.0.0.1:8000/api" : "http://10.0.2.2:8000/api";

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    } else {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return LoginResponse.fromJson(data);
    }
  }

  Future<List<Report>> fetchReports() async {
    final response = await http.get(Uri.parse('$baseUrl/reports'));

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body);
      List<dynamic> reportList;
      if (parsed is Map && parsed.containsKey('reports')) {
        reportList = parsed['reports'];
      } else if (parsed is List) {
        reportList = parsed;
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
      List<Report> reports = reportList.map((dynamic item) {
        var report = Report.fromJson(item);
        // Mapeo con las nuevas claves
        report.buildingName = item['buildingID'] ?? '';
        report.roomName = item['roomID'] ?? '';
        report.categoryName = item['categoryID'] ?? '';
        report.goodName = item['goodID'] ?? '';
        report.userName = item['id'] ?? '';
        report.statusName = item['status'] ?? '';
        return report;
      }).toList();
      return reports;
    } else {
      throw Exception('Failed to load reports');
    }
  }

  Future<List<Report>> fetchReportsByPriority(String priority) async {
    final response = await http.post(
      Uri.parse('$baseUrl/getreportsbypriority'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'priority': priority,
      }),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Report> reports = body.map((dynamic item) {
        var report = Report.fromJson(item);
        report.buildingName = item['building_name'];
        report.roomName = item['room_name'];
        report.categoryName = item['category_name'];
        report.goodName = item['good_name'];
        report.userName = item['user_name'];
        report.statusName = item['status_name'];
        return report;
      }).toList();
      return reports;
    } else {
      throw Exception('Failed to load reports by priority: ${response.reasonPhrase}');
    }
  }

  Future<List<Diagnostic>> fetchDiagnosticsByStatus(String status) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/getalldiagnosticsstatus?status=$status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<Diagnostic> diagnostics = body.map((dynamic item) {
          return Diagnostic.fromJson(item);
        }).toList();
        return diagnostics;
      } else {
        throw Exception('Failed to load diagnostics: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load diagnostics: $e');
    }
  }

  Future<Report> fetchReportByFolio(String folio) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getreportbyfolio?folio=$folio'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      var report = Report.fromJson(data);
      report.buildingName = data['building_name'];
      report.roomName = data['room_name'];
      report.categoryName = data['category_name'];
      report.goodName = data['good_name'];
      report.userName = data['user_name'];
      report.statusName = data['status_name'];
      return report;
    } else if (response.statusCode == 404) {
      throw Exception('Folio no encontrado');
    } else {
      throw Exception('Failed to load report: ${response.reasonPhrase}');
    }
  }

  Future<int> postDiagnostic({
    required int reportID,
    required String description,
    required String status,
    String? images,
    List<Map<String, dynamic>>? materials,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/postdiagnostic'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'reportID': reportID,
        'description': description,
        'images': 'imagen',
        'status': status,
        'materials': materials ?? [],
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['diagnosticID'];
    } else {
      throw Exception('Failed to post diagnostic: ${response.reasonPhrase}');
    }
  }

  Future<void> postMaterials({
    required int diagnosticID,
    required List<Map<String, dynamic>> materials,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/postmaterials'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'diagnosticID': diagnosticID,
        'materials': materials,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to post materials: ${response.reasonPhrase}');
    }
  }

  Future<List<Map<String, dynamic>>> fetchMaterialsByDiagnostic(int diagnosticID) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getmaterialsbydiagnostic/$diagnosticID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Map<String, dynamic>> materials = body.map((dynamic item) {
        return {
          'name': item['name'],
          'supplier': item['supplier'],
          'quantity': item['quantity'],
          'price': item['price'],
        };
      }).toList();
      return materials;
    } else {
      throw Exception('Failed to load materials: ${response.reasonPhrase}');
    }
  }

  Future<int> fetchReportStatus(int reportID) async {
    final response = await http.get(
      Uri.parse('$baseUrl/getreportstatus/$reportID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['statusID'];
    } else {
      throw Exception('Failed to fetch report status: ${response.reasonPhrase}');
    }
  }

  Future<void> changeReportStatus(int reportID, String status) async {
    final response = await http.post(
      Uri.parse('$baseUrl/changereportstatus'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'reportID': reportID,
        'status': status,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to change report status: ${response.reasonPhrase}');
    }
  }
}
