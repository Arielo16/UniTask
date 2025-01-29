// lib/screens/report_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';
import 'diagnostic_screen.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalles del Reporte'),
        backgroundColor: Colors.green[700],
        elevation: 4,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiagnosticScreen(report: report),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[800], // Color de fondo
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                textStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                foregroundColor: Colors.white, // Cambiar el color del texto
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add_circle_outline, color: Colors.white),
                  SizedBox(width: 8),
                  Text('Diagnosticar'),
                ],
              ),
            ),
            SizedBox(height: 30),
            Card(
              elevation: 10,
              shadowColor: const Color.fromARGB(255, 23, 129, 28),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              color: Colors.green[50],
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Folio', report.folio),
                    _buildDetailRow('ID de Edificio', report.buildingID),
                    _buildDetailRow('ID de Habitación', report.roomID),
                    _buildDetailRow(
                        'ID de Categoría', report.categoryID.toString()),
                    _buildDetailRow('ID de Bien', report.goodID.toString()),
                    _buildDetailRow('Prioridad', report.priority),
                    _buildDetailRow('Descripción', report.description),
                    _buildDetailRow('Estado', report.status),
                    _buildDetailRow('Creado en', report.createdAt.toString()),
                    _buildDetailRow(
                        'Actualizado en', report.updatedAt.toString()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green[700],
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
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
