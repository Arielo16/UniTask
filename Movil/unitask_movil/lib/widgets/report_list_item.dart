import 'package:flutter/material.dart';
import '../models/Reports.dart';
import '../screens/report_detail_screen.dart';
import '../theme/colors.dart';

class ReportListItem extends StatelessWidget {
  final Report report;

  const ReportListItem({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      tileColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      leading: CircleAvatar(
        backgroundColor: AppColors.primaryColor,
        child: Text(
          report.folio.substring(0, 2).toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
      ),
      title: Text(
        'Folio: ${report.folio}',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18,
          color: Color(0xFF00664F),
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          Text(
            'Prioridad: ${report.priority ?? 'No disponible'}',
            style: const TextStyle(
              fontSize: 16,
              color: Colors.black54,
            ),
          ),
        ],
      ),
      trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4DC591)),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ReportDetailScreen(report: report),
          ),
        );
      },
    );
  }
}
