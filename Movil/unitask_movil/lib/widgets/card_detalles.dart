import 'package:flutter/material.dart';
import '../models/Reports.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; // Agregado para formatear la fecha

class CardDetalles extends StatelessWidget {
  final Report report;

  const CardDetalles({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.transparent),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildDetailRow('Folio', report.folio),
            _buildDetailRow('Edificio', report.buildingName ?? 'No disponible'),
            _buildDetailRow('Habitación', report.roomName ?? 'No disponible'),
            _buildDetailRow('Categoría', report.categoryName ?? 'No disponible'),
            _buildDetailRow('Bien', report.goodName ?? 'No disponible'),
            _buildDetailRow('Prioridad', report.priority),
            _buildDetailRow('Descripción', report.description),
            _buildDetailRow('Usuario que reporto', report.userName ?? 'No disponible'),
            _buildImageSection(report.image),
            // Se formatea la fecha para mostrar día, mes y año
            _buildDetailRow('Creado en', DateFormat('dd/MM/yyyy').format(report.createdAt)),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$title: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF00664F), // Set text color
              fontSize: 16,
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.center,
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
