// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Reports.dart';

class ApiService {
  final String baseUrl = "http://localhost:8000/api"; // Cambia esto a la URL correcta

  Future<List<Report>> fetchReports() async {
    final response = await http.get(Uri.parse('$baseUrl/reports/diagnostiqued'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Report> reports = body.map((dynamic item) => Report.fromJson(item)).toList();
      return reports;
    } else {
      throw Exception('Failed to load reports');
    }
  }
}