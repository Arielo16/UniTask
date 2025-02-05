import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/Reports.dart';
import '../widgets/report_card.dart';
import 'report_detail_screen.dart';
import 'diagnostics_screen.dart';
import 'history_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Report>> futureReports;
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 0;
  List<Report> searchedReports = [];

  @override
  void initState() {
    super.initState();
    _loadReports();
  }

  void _loadReports() {
    setState(() {
      futureReports = ApiService().fetchReports();
    });
  }

  void _searchReport() async {
    try {
      final report = await ApiService().fetchReportByFolio(_searchController.text);
      setState(() {
        searchedReports = [report];
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString())),
      );
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      searchedReports = []; // Clear the searched reports when switching tabs
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [
      _buildReportsScreen(),
      const DiagnosticsScreen(),
      const HistoryScreen(),
    ];

    List<String> titles = [
      'Reportes',
      'Diagnósticos en Proceso',
      'Historial de Diagnósticos',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[_selectedIndex], style: const TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF00664F),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              _loadReports();
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
        selectedItemColor: Colors.green[800],
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
                return ReportCard(report: report);
              },
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
                        final report = snapshot.data![index];
                        return ReportCard(report: report);
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