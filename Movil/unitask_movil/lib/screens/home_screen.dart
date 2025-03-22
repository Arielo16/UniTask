import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/Reports.dart';
import '../models/Diagnostic.dart';
import '../widgets/report_list_item.dart';
import 'diagnostic_detail_screen.dart';
import '../theme/colors.dart';
import '../models/report_by_folio.dart';
import '../widgets/report_card.dart'; // Agregado para definir ReportCard
import '../screens/report_detail_screen.dart'; // Agregado para definir ReportDetailScreen

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
  String selectedStatus = 'En Proceso';
  String selectedPriority = 'Immediate';
  List<Report> searchedReports = [];
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _loadReports();
    _loadDiagnostics();
    _loadHistoryDiagnostics();
  }

  void _loadReports({int page = 1}) {
    setState(() {
      futureReports = ApiService().fetchReports(page: page).then((data) {
        _currentPage = data['pagination']['current_page'];
        _totalPages = data['pagination']['last_page'];
        return data['reports'];
      });
    });
  }

  void _loadReportsByPriority() {
    setState(() {
      futureReports = ApiService().fetchReportsByPriority(selectedPriority);
    });
  }

  void _loadDiagnostics({int page = 1}) {
    setState(() {
      futureDiagnostics = ApiService()
          .fetchDiagnosticsByStatus(selectedStatus, page: page)
          .then((data) {
        return data['diagnostics'];
      });
    });
  }

  void _loadHistoryDiagnostics({int page = 1}) {
    setState(() {
      futureHistoryDiagnostics = ApiService()
          .fetchDiagnosticsByStatus(selectedStatus, page: page)
          .then((data) {
        return data['diagnostics'];
      });
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
        title: Text(titles[_selectedIndex],
            style: const TextStyle(color: Colors.white)),
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
      body: Column(
        children: [
          Expanded(child: screens[_selectedIndex]),
          if (_selectedIndex == 0) _buildPaginationControls(),
        ],
      ),
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
        // Nueva sección de búsqueda con diseño moderno
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(2, 2))
                    ],
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar por Folio',
                      prefixIcon:
                          Icon(Icons.search, color: AppColors.primaryColor),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 16),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _searchReport,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  backgroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.all(16),
                ),
                child: const Icon(Icons.search, color: Colors.white),
              ),
            ],
          ),
        ),
        // Nuevo diseño para el select/dropdown
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: AppColors.primaryColor, width: 2),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedPriority,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedPriority = newValue!;
                    _loadReportsByPriority();
                  });
                },
                items: <String>['Immediate', 'Normal']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        // Redesigned cards para presentar los reportes
        if (searchedReports.isNotEmpty)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: searchedReports.length,
              itemBuilder: (context, index) {
                final report = searchedReports[index];
                // Usamos ReportCard (o ReportListItem) que tenga el onTap configurado
                return ReportCard(report: report);
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
                        return Container(
                          margin: const EdgeInsets.only(bottom: 16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                AppColors.primaryColor.withOpacity(0.9),
                                AppColors.secondaryColor.withOpacity(0.9),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(2, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16),
                            title: Text(
                              'Folio: ${report.folio}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              report.description,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.white70,
                              ),
                            ),
                            trailing: const Icon(Icons.arrow_forward,
                                color: Colors.white),
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  tileColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    child: Text(
                      diagnostic.reportFolio.length >= 2
                          ? diagnostic.reportFolio.substring(0, 2).toUpperCase()
                          : diagnostic.reportFolio.toUpperCase(),
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
                  trailing:
                      const Icon(Icons.arrow_forward, color: Color(0xFF4DC591)),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DiagnosticDetailScreen(
                            reportID: diagnostic.reportID),
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
                  items: <String>[
                    'Enviado',
                    'Diagnosticado',
                    'En Proceso',
                    'Terminado'
                  ].map<DropdownMenuItem<String>>((String value) {
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
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        tileColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        leading: CircleAvatar(
                          backgroundColor: AppColors.primaryColor,
                          child: Text(
                            diagnostic.reportFolio.length >= 2
                                ? diagnostic.reportFolio
                                    .substring(0, 2)
                                    .toUpperCase()
                                : diagnostic.reportFolio.toUpperCase(),
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
                        trailing: const Icon(Icons.arrow_forward,
                            color: Color(0xFF4DC591)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DiagnosticDetailScreen(
                                  reportID: diagnostic.reportID),
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

  Widget _buildPaginationControls() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: _currentPage > 1
                ? () => _loadReports(page: _currentPage - 1)
                : null,
            child: const Text('Previous'),
          ),
          Text('Page $_currentPage of $_totalPages'),
          ElevatedButton(
            onPressed: _currentPage < _totalPages
                ? () => _loadReports(page: _currentPage + 1)
                : null,
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
