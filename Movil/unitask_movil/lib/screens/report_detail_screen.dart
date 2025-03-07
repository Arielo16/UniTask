// lib/screens/report_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';
import 'diagnostic_screen.dart';
import '../widgets/card_detalles.dart';
import '../theme/colors.dart';
import '../services/api_service.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  const ReportDetailScreen({super.key, required this.report});

  void _checkReportStatusAndNavigate(BuildContext context) async {
    try {
      final canDiagnose = await ApiService().fetchReportStatus(report.reportID);
      if (canDiagnose) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiagnosticScreen(report: report),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('El reporte ya está en proceso')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Reporte',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
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
                  onPressed: () => _checkReportStatusAndNavigate(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
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
}
