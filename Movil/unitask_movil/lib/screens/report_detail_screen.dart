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
        backgroundColor: Colors.green,
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
                backgroundColor: Colors.green,
              ),
              child: Text('Diagnosticar'),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDetailRow('Folio', report.folio),
                    _buildDetailRow('Building ID', report.buildingID),
                    _buildDetailRow('Room ID', report.roomID),
                    _buildDetailRow('Category ID', report.categoryID.toString()),
                    _buildDetailRow('Good ID', report.goodID.toString()),
                    _buildDetailRow('Priority', report.priority),
                    _buildDetailRow('Description', report.description),
                    _buildDetailRow('Status', report.status),
                    _buildDetailRow('Created At', report.createdAt.toString()),
                    _buildDetailRow('Updated At', report.updatedAt.toString()),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }
}