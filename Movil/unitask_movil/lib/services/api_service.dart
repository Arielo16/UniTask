// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/Reports.dart';
import '../models/Diagnostic.dart';

class ApiService {
  final String baseUrl =
      //"http://10.0.2.2:8000/api";
      "https://apiunitaskproduction-production.up.railway.app/api";
  //"http://localhost:8000/api";

  Future<LoginResponse> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users/verifyLogin'),
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
    final response = await http.get(Uri.parse('$baseUrl/reports/get'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Report> reports = body.map((dynamic item) {
        var report = Report.fromJson(item);
        report.buildingName =
            item['building']['key']; // Use 'key' instead of 'name'
        report.roomName = item['room']['name'];
        report.categoryName = item['category']['name'];
        report.goodName = item['goods']['name'];
        report.userName = item['user']['name'];
        report.statusName = item['status']['name'];
        return report;
      }).toList();
      return reports;
    } else {
      throw Exception('Failed to load reports');
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
      return Report.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Folio no encontrado');
    } else {
      throw Exception('Failed to load report: ${response.reasonPhrase}');
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

  Future<int> postDiagnostic({
    required int reportID,
    required String description,
    required String status,
    String? images,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/postdiagnostic'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'reportID': reportID,
        'description': description,
        'status': status,
        'images': images,
      }),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['diagnosticID'];
    } else {
      throw Exception('Failed to post diagnostic: ${response.reasonPhrase}');
    }
  }
}
