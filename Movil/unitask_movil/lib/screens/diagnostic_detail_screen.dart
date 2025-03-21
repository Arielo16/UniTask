import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/Diagnostic.dart';
import '../theme/colors.dart';
import '../services/api_service.dart';

class DiagnosticDetailScreen extends StatefulWidget {
  final int reportID;

  const DiagnosticDetailScreen({super.key, required this.reportID});

  @override
  _DiagnosticDetailScreenState createState() => _DiagnosticDetailScreenState();
}

class _DiagnosticDetailScreenState extends State<DiagnosticDetailScreen> {
  late Future<Diagnostic> _futureDiagnosticDetail;

  @override
  void initState() {
    super.initState();
    _futureDiagnosticDetail = _fetchDiagnosticDetail();
  }

  Future<Diagnostic> _fetchDiagnosticDetail() async {
    final url = Uri.parse('https://apiunitask-production.up.railway.app/api/diagnostics/report/${widget.reportID}');
    final response = await http.get(url, headers: {'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      if (parsed is Map && parsed.containsKey('diagnostic')) {
        final diagnosticJson = parsed['diagnostic'];
        if (diagnosticJson == null) {
          throw Exception("La propiedad 'diagnostic' es null");
        }
        return Diagnostic.fromJson(diagnosticJson);
      } else {
        throw Exception('Formato de respuesta inesperado');
      }
    } else {
      throw Exception('Failed to load diagnostic detail: ${response.reasonPhrase}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Diagnóstico', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: FutureBuilder<Diagnostic>(
        future: _futureDiagnosticDetail,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontraron detalles'));
          } else {
            Diagnostic diag = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Información general con gradiente
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primaryColor.withOpacity(0.85),
                          AppColors.secondaryColor.withOpacity(0.85)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: const [ 
                        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2,2)),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Descripción:', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text(diag.description, style: const TextStyle(fontSize: 18, color: Colors.white70)),
                        const SizedBox(height: 16),
                        Text('Estado: ${diag.status}', style: const TextStyle(fontSize: 18, color: Colors.white)),
                        const SizedBox(height: 8),
                        Text('Creado: ${diag.createdAt}', style: const TextStyle(fontSize: 16, color: Colors.white70)),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Imagen
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Imagen:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Builder(
                        builder: (context) {
                          final prefix = "http://127.0.0.1:8000/storage/";
                          final originalUrl = diag.images!;
                          final imageUrl = originalUrl.startsWith(prefix)
                              ? originalUrl.substring(prefix.length)
                              : originalUrl;
                          return Image.network(
                            imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Text('No se pudo cargar la imagen'),
                          );
                        },
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                  // Materiales
                  Text('Materiales:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                  const SizedBox(height: 12),
                  diag.materials.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: diag.materials.length,
                          itemBuilder: (context, index) {
                            final material = diag.materials[index];
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 8.0,
                                    offset: Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(material['name'], style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                  const SizedBox(height: 8.0),
                                  Text('Cantidad: ${material['quantity']}', style: const TextStyle(fontSize: 16.0)),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(child: Text('No hay materiales disponibles', style: TextStyle(fontSize: 16, color: Colors.grey[700]))),
                  const SizedBox(height: 24),
                  // ...any future extensions...
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
