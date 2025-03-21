// lib/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:http_parser/http_parser.dart'; // Agregado para MediaType
import '../models/login_response.dart';
import '../models/Reports.dart';
import '../models/Diagnostic.dart';
import '../models/report_by_folio.dart';

class ApiService {
  // Cambiar la URL base según el entorno
  final String baseUrl =  'https://apiunitask-production.up.railway.app/api';

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
    final response = await http.get(
      Uri.parse('$baseUrl/reports/priority/$priority'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

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
      throw Exception('Failed to load reports by priority: ${response.reasonPhrase}');
    }
  }

  Future<List<Diagnostic>> fetchDiagnosticsByStatus(String status) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/diagnostics/status/$status'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        final parsed = json.decode(response.body);
        List<dynamic> body;
        if (parsed is Map) {
          if (parsed.containsKey('diagnostic')) {
            // Single diagnostic response: remove materials and wrap in a list.
            Map<String, dynamic> diagnosticData = Map.from(parsed['diagnostic']);
            diagnosticData.remove('materials');
            return [Diagnostic.fromJson(diagnosticData)];
          } else if (parsed.containsKey('diagnostics')) {
            body = parsed['diagnostics'];
            // Remove materials from each diagnostic.
            body = body.map((item) {
              var diag = Map<String, dynamic>.from(item);
              diag.remove('materials');
              return diag;
            }).toList();
          } else {
            throw Exception('Formato de respuesta inesperado');
          }
        } else if (parsed is List) {
          body = parsed.map((item) {
            var diag = Map<String, dynamic>.from(item);
            diag.remove('materials');
            return diag;
          }).toList();
        } else {
          throw Exception('Formato de respuesta inesperado');
        }
        return body.map((dynamic item) => Diagnostic.fromJson(item)).toList();
      } else {
        throw Exception('Failed to load diagnostics: ${response.reasonPhrase}');
      }
    } catch (e) {
      throw Exception('Failed to load diagnostics: $e');
    }
  }

  Future<Report> fetchReportByFolio(String folio) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reports/folio/$folio'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      // Extrae el objeto 'report' de la respuesta
      final Map<String, dynamic> outer = jsonDecode(response.body);
      final Map<String, dynamic> data = outer['report'];
      var report = Report.fromJson(data);
      // Asigna los nombres usando las nuevas claves
      report.buildingName = data['buildingID'] ?? '';
      report.roomName = data['roomID'] ?? '';
      report.categoryName = data['categoryID'] ?? '';
      report.goodName = data['goodID'] ?? '';
      report.userName = data['id'] ?? '';
      report.statusName = data['status'] ?? '';
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
    required String status, // "Enviado", "Para Reparar", "En Proceso", "Terminado"
    File? images, // Se recibe la imagen en lugar de la ruta
    List<Map<String, int>>? materials, // Lista de materiales con materialID y quantity
  }) async {
    final uri = Uri.parse('$baseUrl/diagnostics/create');
    final request = http.MultipartRequest('POST', uri);
    request.fields['reportID'] = reportID.toString();
    request.fields['description'] = description;
    request.fields['status'] = status;
    // Enviar los materiales en formato form-data: materials[0][materialID], materials[0][quantity], etc.
    if (materials != null) {
      for (int i = 0; i < materials.length; i++) {
        var material = materials[i];
        request.fields['materials[$i][materialID]'] = material['materialID'].toString();
        request.fields['materials[$i][quantity]'] = material['quantity'].toString();
      }
    }
    if (images != null) {
      var stream = http.ByteStream(images.openRead());
      var length = await images.length();
      request.files.add(
        http.MultipartFile(
          'images',
          stream,
          length,
          filename: images.path.split('/').last,
          contentType: MediaType('images', 'jpeg'),
        ),
      );
    }
    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    if (response.statusCode == 201) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Se extrae diagnosticID desde el objeto "diagnostic"
      final diagnostic = data['diagnostic'];
      if (diagnostic == null || diagnostic['diagnosticID'] == null) {
        throw Exception('La API retornó diagnostic o diagnosticID null');
      }
      return diagnostic['diagnosticID'];
    } else {
      throw Exception('Failed to post diagnostic: ${response.reasonPhrase}');
    }
  }

  Future<bool> fetchReportStatus(int reportID) async {
    final response = await http.get(
      Uri.parse('$baseUrl/reports/check-status/$reportID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      // Asumimos que API retorna statusID == 1 cuando es true
      return data['status'] == true;
    } else {
      throw Exception('Failed to fetch report status: ${response.reasonPhrase}');
    }
  }

  // Se agrega el siguiente método para obtener el detalle completo del diagnóstico:
  Future<Diagnostic> fetchDiagnosticDetail(int diagnosticID) async {
    final response = await http.get(
      Uri.parse('$baseUrl/diagnostics/report/$diagnosticID'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      if (parsed.containsKey('diagnostics')) {
        final diagnosticsList = parsed['diagnostics'] as List<dynamic>;
        if (diagnosticsList.isEmpty) {
          throw Exception('No se encontraron diagnósticos');
        }
        final diagnosticJson = diagnosticsList.firstWhere(
          (diag) => diag['diagnosticID'] == diagnosticID,
          orElse: () => null,
        );
        if (diagnosticJson == null) {
          throw Exception('Diagnóstico con id $diagnosticID no encontrado');
        }
        return Diagnostic.fromJson(diagnosticJson);
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
    } else {
      throw Exception('Failed to load diagnostic detail: ${response.reasonPhrase}');
    }
  }

  // Nuevo método para obtener la lista de materiales
  Future<List<Map<String, dynamic>>> fetchMaterials() async {
    final response = await http.get(Uri.parse('$baseUrl/materials'));
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      List<dynamic> materials = parsed['materials'];
      return materials.map<Map<String, dynamic>>((item) => item).toList();
    } else {
      throw Exception('Failed to fetch materials: ${response.reasonPhrase}');
    }
  }
}
