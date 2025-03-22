import 'package:flutter/material.dart';
import '../models/Diagnostic.dart';
import '../services/api_service.dart';
import 'diagnostic_detail_screen.dart';
import '../theme/colors.dart';
import '../widgets/diagnostic_card.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  late Future<Map<String, dynamic>> futureDiagnostics;
  String selectedStatus = 'Enviado';

  final Map<String, String> _statusOptions = {
    'Enviado': 'Enviado',
    'En Proceso': 'En Proceso',
    'Enviado a Aprobación': 'Enviado a Aprobacion',
    'Terminado': 'Terminado',
  };

  @override
  void initState() {
    super.initState();
    _loadDiagnostics();
  }

  void _loadDiagnostics({int page = 1}) {
    setState(() {
      futureDiagnostics = ApiService()
          .fetchDiagnosticsByStatus(_statusOptions[selectedStatus]!, page: page)
          .then((data) {
        return data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Historial de Diagnósticos',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      border:
                          Border.all(color: AppColors.primaryColor, width: 2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedStatus,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedStatus = newValue!;
                            _loadDiagnostics();
                          });
                        },
                        items: _statusOptions.keys
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loadDiagnostics,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: AppColors.primaryColor,
                    padding: const EdgeInsets.all(16),
                  ),
                  child: const Icon(Icons.search, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _loadDiagnostics();
              },
              child: FutureBuilder<Map<String, dynamic>>(
                future: futureDiagnostics,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text('Error: ${snapshot.error}',
                            style: const TextStyle(
                                color: Colors.red, fontSize: 16)));
                  } else if (!snapshot.hasData ||
                      snapshot.data!['diagnostics'].isEmpty) {
                    return const Center(
                        child: Text('No diagnostics found',
                            style:
                                TextStyle(fontSize: 18, color: Colors.grey)));
                  } else {
                    final diagnostics = snapshot.data!['diagnostics'];
                    return GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16,
                        childAspectRatio: 0.85,
                      ),
                      itemCount: diagnostics.length,
                      itemBuilder: (context, index) {
                        final diagnostic = diagnostics[index];
                        return DiagnosticCard(diagnostic: diagnostic);
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
