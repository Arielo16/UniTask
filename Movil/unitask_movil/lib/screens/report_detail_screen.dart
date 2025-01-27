// lib/screens/report_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/Reports.dart';
import 'diagnostic_screen.dart';

class ReportDetailScreen extends StatelessWidget {
  final Report report;

  ReportDetailScreen({required this.report});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Folio: ${report.folio}'),
            Text('Building ID: ${report.buildingID}'),
            Text('Room ID: ${report.roomID}'),
            Text('Category ID: ${report.categoryID}'),
            Text('Good ID: ${report.goodID}'),
            Text('Priority: ${report.priority}'),
            Text('Description: ${report.description}'),
            Text('User ID: ${report.userID}'),
            Text('Status: ${report.status}'),
            Text('Created At: ${report.createdAt}'),
            Text('Updated At: ${report.updatedAt}'),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DiagnosticScreen(report: report),
                    ),
                  );
                },
                child: Text('Diagnosticar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}