// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/Reports.dart';
import '../widgets/report_card.dart';
import 'report_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Report>> futureReports;

  @override
  void initState() {
    super.initState();
    futureReports = ApiService().fetchReports();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        backgroundColor: Colors.green,
      ),
      body: FutureBuilder<List<Report>>(
        future: futureReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No reports found'));
          } else {
            return ListView(
              children: snapshot.data!.map((report) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text('Folio: ${report.folio}'),
                    subtitle: Text('Building ID: ${report.buildingID}\nRoom ID: ${report.roomID}'),
                    trailing: Icon(Icons.arrow_forward, color: Colors.green),
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
              }).toList(),
            );
          }
        },
      ),
    );
  }
}