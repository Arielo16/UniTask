// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_response.dart';
import '../models/Reports.dart';

class ApiService {
  final String baseUrl =
      "http://localhost:8000/api"; // Cambia esto a la URL correcta para el emulador

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
    final response =
        await http.get(Uri.parse('$baseUrl/reports/diagnostiqued'));

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      List<Report> reports =
          body.map((dynamic item) => Report.fromJson(item)).toList();
      return reports;
    } else {
      throw Exception('Failed to load reports');
    }
  }
}
