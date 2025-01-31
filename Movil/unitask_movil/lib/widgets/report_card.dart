// lib/widgets/report_card.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';
import '../screens/report_detail_screen.dart';

class ReportCard extends StatelessWidget {
  final Report report;

  const ReportCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportDetailScreen(report: report),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          constraints: BoxConstraints(minHeight: 150), // Asegurar un tamaño mínimo
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Folio: ${report.folio}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF00664F),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Edificio: ${report.buildingName ?? 'No disponible'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              Text(
                'Salón: ${report.roomName ?? 'No disponible'}',
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Icon(
                  Icons.arrow_forward,
                  color: const Color(0xFF4DC591),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}