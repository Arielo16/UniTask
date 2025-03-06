import 'package:flutter/material.dart';
import '../models/Diagnostic.dart';
import '../theme/colors.dart';
import '../services/api_service.dart';

class DiagnosticDetailScreen extends StatefulWidget {
  final Diagnostic diagnostic;

  const DiagnosticDetailScreen({super.key, required this.diagnostic});

  @override
  _DiagnosticDetailScreenState createState() => _DiagnosticDetailScreenState();
}

class _DiagnosticDetailScreenState extends State<DiagnosticDetailScreen> {
  late Future<Diagnostic> _futureDiagnosticDetail;

  @override
  void initState() {
    super.initState();
    // Se usa el nuevo endpoint para obtener detalles completos (con materiales)
    _futureDiagnosticDetail = ApiService().fetchDiagnosticDetail(widget.diagnostic.diagnosticID);
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
            Diagnostic diagnosticDetail = snapshot.data!;
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Tarjeta de información con diseño moderno y gradiente
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
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
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(2, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Descripción',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          diagnosticDetail.description,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          'Estado',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          diagnosticDetail.status,
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Se muestra la lista de materiales obtenida del endpoint
                  Text(
                    'Materiales:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                  const SizedBox(height: 12),
                  diagnosticDetail.materials.isNotEmpty
                      ? ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: diagnosticDetail.materials.length,
                          itemBuilder: (context, index) {
                            final material = diagnosticDetail.materials[index];
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
                                  Text(
                                    material['name'],
                                    style: TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                      color: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Proveedor: ${material['supplier']}',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Cantidad: ${material['quantity']}',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                  const SizedBox(height: 8.0),
                                  Text(
                                    'Precio: \$${material['price']}',
                                    style: const TextStyle(fontSize: 16.0),
                                  ),
                                ],
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Text(
                            'No hay materiales disponibles',
                            style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                          ),
                        ),
                  const SizedBox(height: 24),
                  // ...existing code for future extensions...
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
