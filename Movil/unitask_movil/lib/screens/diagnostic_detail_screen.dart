import 'package:flutter/material.dart';
import '../models/Diagnostic.dart';
import '../theme/colors.dart';

class DiagnosticDetailScreen extends StatelessWidget {
  final Diagnostic diagnostic;

  const DiagnosticDetailScreen({super.key, required this.diagnostic});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Diagnóstico',
            style: TextStyle(color: Colors.white)), // Set text color to white
        backgroundColor: AppColors.primaryColor, // Set AppBar color
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow('Folio', diagnostic.reportFolio),
                      _buildDetailRow('Descripción', diagnostic.description),
                      _buildDetailRow('Estado', diagnostic.status),
                      _buildDetailRow(
                          'Creado en', diagnostic.createdAt.toString()),
                      if (diagnostic.images != null &&
                          diagnostic.images!.isNotEmpty)
                        _buildDetailRow('Imágenes', diagnostic.images!),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.primaryColor, // Set text color
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
