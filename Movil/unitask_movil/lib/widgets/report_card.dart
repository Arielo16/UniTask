// lib/widgets/report_card.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';
import '../screens/report_detail_screen.dart';

class ReportCard extends StatelessWidget {
  final Report report;

  ReportCard({required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(report.folio),
        subtitle: Text(report.description),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReportDetailScreen(report: report),
            ),
          );
        },
      ),
    );
  }
}