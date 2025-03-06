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
  late Future<List<Diagnostic>> futureDiagnostics;

  @override
  void initState() {
    super.initState();
    _loadDiagnostics();
  }

  void _loadDiagnostics() {
    setState(() {
      futureDiagnostics = ApiService().fetchDiagnosticsByStatus('En Proceso');
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
          _loadDiagnostics();
        },
        child: FutureBuilder<List<Diagnostic>>(
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
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(
                child: Text(
                  'No diagnostics found',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final diagnostic = snapshot.data![index];
                  return DiagnosticCard(diagnostic: diagnostic);
                },
              );
            }
          },
        ),
      ),
    );
  }
}
