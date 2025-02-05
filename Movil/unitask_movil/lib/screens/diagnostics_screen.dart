import 'package:flutter/material.dart';
import '../models/Diagnostic.dart';
import '../services/api_service.dart';
import 'diagnostic_detail_screen.dart';

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
      futureDiagnostics = ApiService().fetchDiagnosticsByStatus('EnProceso');
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
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
            return GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.8,
              ),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final diagnostic = snapshot.data![index];
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
                          builder: (context) =>
                              DiagnosticDetailScreen(diagnostic: diagnostic),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Folio: ${diagnostic.reportFolio}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Color(0xFF00664F),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Descripción: ${diagnostic.description}',
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black54,
                            ),
                          ),
                          const Spacer(),
                          Icon(
                            Icons.arrow_forward,
                            color: const Color(0xFF4DC591),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
