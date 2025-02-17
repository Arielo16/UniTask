import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/Reports.dart';
import '../models/Diagnostic.dart';
import '../widgets/report_list_item.dart';
import 'diagnostic_detail_screen.dart';
import '../theme/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Report>> futureReports;
  late Future<List<Diagnostic>> futureDiagnostics;
  late Future<List<Diagnostic>> futureHistoryDiagnostics;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  String selectedStatus = 'EnProceso';
  List<Report> searchedReports = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
    _loadDiagnostics();
    _loadHistoryDiagnostics();
  }

  void _loadReports() {
    setState(() {
      futureReports = ApiService().fetchReports();
    });
  }

  void _loadDiagnostics() {
    setState(() {
      futureDiagnostics = ApiService().fetchDiagnosticsByStatus(selectedStatus);
    });
  }

  void _loadHistoryDiagnostics() {
    setState(() {
      futureHistoryDiagnostics =
          ApiService().fetchDiagnosticsByStatus(selectedStatus);
    });
  }

  void _searchReport() async {
    try {
      final report =
          await ApiService().fetchReportByFolio(_searchController.text);
      setState(() {
        searchedReports = [report];
      });
    } catch (e) {
      setState(() {
        searchedReports = [];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No encontrado')),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      searchedReports = [];
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      _buildReportsScreen(),
      _buildDiagnosticsScreen(),
      _buildHistoryScreen(),
    ];

    List<String> titles = [
      'Reportes',
      'Diagnósticos en Proceso',
      'Historial de Diagnósticos',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex], style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _loadReports();
              _loadDiagnostics();
              _loadHistoryDiagnostics();
            },
          ),
        ],
      ),
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.report),
            label: 'Reportes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: 'Diagnósticos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Historial',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.primaryColor,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildReportsScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    labelText: 'Buscar por Folio',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF00664F)),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF00664F)),
                onPressed: _searchReport,
              ),
            ],
          ),
        ),
        if (searchedReports.isNotEmpty)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: searchedReports.length,
              itemBuilder: (context, index) {
                final report = searchedReports[index];
                return ReportListItem(report: report);
              },
            ),
          )
        else if (_searchController.text.isNotEmpty)
          const Center(
            child: Text(
              'No encontrado',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          )
        else
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                _loadReports();
              },
              child: FutureBuilder<List<Report>>(
                future: futureReports,
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
                        'No reports found',
                        style: TextStyle(fontSize: 18, color: Colors.grey),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final report = snapshot.data![index];
                        return ReportListItem(report: report);
                      },
                    );
                  }
                },
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildDiagnosticsScreen() {
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
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final diagnostic = snapshot.data![index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      diagnostic.reportFolio.substring(0, 2).toUpperCase(),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  title: Text(
                    'Folio: ${diagnostic.reportFolio}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Color(0xFF00664F),
                    ),
                  ),
                  subtitle: Text(
                    'Descripción: ${diagnostic.description}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4DC591)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiagnosticDetailScreen(diagnostic: diagnostic),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildHistoryScreen() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: DropdownButton<String>(
                  value: selectedStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                      _loadHistoryDiagnostics();
                    });
                  },
                  items: <String>['Completado', 'EnProceso', 'Enviado']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.search, color: Color(0xFF00664F)),
                onPressed: _loadHistoryDiagnostics,
              ),
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              _loadHistoryDiagnostics();
            },
            child: FutureBuilder<List<Diagnostic>>(
              future: futureHistoryDiagnostics,
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
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Text(
                            diagnostic.reportFolio.substring(0, 2).toUpperCase(),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        title: Text(
                          'Folio: ${diagnostic.reportFolio}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Color(0xFF00664F),
                          ),
                        ),
                        subtitle: Text(
                          'Descripción: ${diagnostic.description}',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black54,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward, color: Color(0xFF4DC591)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiagnosticDetailScreen(diagnostic: diagnostic),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
