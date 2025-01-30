// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Reports.dart';

class ApiService {
  final String baseUrl = "http://localhost:8000/api"; // Cambia esto a la URL correcta
  //http://10.0.2.2:8000/api pa telefono
  //http://localhost:8000/api pa emulador

  Future<bool> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      // Si el servidor devuelve un código 200 OK, parsea el JSON
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Aquí puedes guardar el token de autenticación si es necesario
      // Por ejemplo: await saveToken(data['token']);
      return true;
    } else {
      // Si la respuesta no fue 200, lanza un error
      return false;
    }
  }
  
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