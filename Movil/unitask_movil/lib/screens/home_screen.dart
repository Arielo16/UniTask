// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/Reports.dart';
import '../widgets/report_card.dart';
import 'report_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
        backgroundColor: Colors.green[800],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                futureReports =
                    ApiService().fetchReports(); // Refresh the reports
              });
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Report>>(
        future: futureReports,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text('No reports found',
                    style: TextStyle(fontSize: 18, color: Colors.grey)));
          } else {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: snapshot.data!.map((report) {
                return Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  color:
                      const Color.fromARGB(255, 13, 143, 82), // Fondo del Card
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16),
                    title: Text(
                      'Folio: ${report.folio}',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(
                              255, 3, 3, 3)), // Color del título
                    ),
                    subtitle: Text(
                      'Edificio: ${report.buildingID}\nSalon: ${report.roomID}',
                      style: TextStyle(
                          color: const Color.fromARGB(
                              255, 254, 253, 253)), // Color del subtítulo
                    ),
                    trailing: Icon(Icons.arrow_forward,
                        color: const Color.fromARGB(255, 240, 242, 240)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ReportDetailScreen(report: report),
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
