import 'package:flutter/material.dart';
import '../models/Diagnostic.dart';
import '../services/api_service.dart';
import 'diagnostic_detail_screen.dart';
import '../theme/colors.dart';
import '../widgets/diagnostic_card.dart'; // Agregado para usar DiagnosticCard

class DiagnosticsScreen extends StatefulWidget {
  const DiagnosticsScreen({super.key});

  @override
  _DiagnosticsScreenState createState() => _DiagnosticsScreenState();
}

class _DiagnosticsScreenState extends State<DiagnosticsScreen> {
  late Future<Map<String, dynamic>> futureDiagnostics;
  int currentPage = 1;
  int totalPages = 1;
  String selectedStatus = 'En Proceso';

  @override
  void initState() {
    super.initState();
    _loadDiagnostics();
  }

  void _loadDiagnostics({int page = 1}) {
    setState(() {
      futureDiagnostics = ApiService()
          .fetchDiagnosticsByStatus(selectedStatus, page: page)
          .then((data) {
        return data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnósticos en Proceso',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _loadDiagnostics(page: currentPage);
        },
        child: FutureBuilder<Map<String, dynamic>>(
          future: futureDiagnostics,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            } else if (!snapshot.hasData ||
                snapshot.data!['diagnostics'].isEmpty) {
              return const Center(
                child: Text(
                  'No diagnostics found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            } else {
              final diagnostics = snapshot.data!['diagnostics'];
              final pagination = snapshot.data!['pagination'];
              currentPage = pagination['current_page'];
              totalPages = pagination['last_page'];

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: diagnostics.length,
                      itemBuilder: (context, index) {
                        final diagnostic = diagnostics[index];
                        return DiagnosticCard(diagnostic: diagnostic);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: currentPage > 1
                            ? () => _loadDiagnostics(page: currentPage - 1)
                            : null,
                        child: const Text('Previous'),
                      ),
                      ElevatedButton(
                        onPressed: currentPage < totalPages
                            ? () => _loadDiagnostics(page: currentPage + 1)
                            : null,
                        child: const Text('Next'),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
