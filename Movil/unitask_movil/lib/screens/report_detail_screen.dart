// lib/screens/report_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';
import 'diagnostic_screen.dart';
import 'dart:convert';
import '../widgets/card_detalles.dart';
import '../theme/colors.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Reporte',
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
              CardDetalles(report: report),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print(
                        'Navigating to DiagnosticScreen with reportID: ${report.reportID}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiagnosticScreen(report: report),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        AppColors.primaryColor, // Set button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 14),
                    textStyle: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.add_circle_outline, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Diagnosticar'),
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

  Widget _buildImageSection(String? base64Image) {
    if (base64Image != null && base64Image.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.memory(
          base64Decode(base64Image),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[300],
          child: Center(
            child: Text(
              'No hay imagen disponible',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }
  }
}

class DetallesCard extends StatelessWidget {
  final Report report;

  const DetallesCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Folio', report.folio),
            _buildDetailRow('Edificio', report.buildingName ?? 'No disponible'),
            _buildDetailRow('Habitación', report.roomName ?? 'No disponible'),
            _buildDetailRow(
                'Categoría', report.categoryName ?? 'No disponible'),
            _buildDetailRow('Bien', report.goodName ?? 'No disponible'),
            _buildDetailRow('Prioridad', report.priority),
            _buildDetailRow('Descripción', report.description),
            _buildImageSection(report.image),
            _buildDetailRow('Usuario', report.userName ?? 'No disponible'),
            _buildDetailRow('Estado', report.statusName ?? 'No disponible'),
            _buildDetailRow(
                'Requiere Aprobación', report.requiresApproval ? 'Sí' : 'No'),
            _buildDetailRow(
                'Involucra Terceros', report.involveThirdParties ? 'Sí' : 'No'),
            _buildDetailRow('Creado en', report.createdAt.toString()),
            _buildDetailRow('Actualizado en', report.updatedAt.toString()),
          ],
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

  Widget _buildImageSection(String? base64Image) {
    if (base64Image != null && base64Image.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Image.memory(
          base64Decode(base64Image),
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey[300],
          child: Center(
            child: Text(
              'No hay imagen disponible',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 16,
              ),
            ),
          ),
        ),
      );
    }
  }
}
