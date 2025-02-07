import 'package:flutter/material.dart';
import '../models/Reports.dart';
import '../services/api_service.dart';
import '../theme/colors.dart';

class DiagnosticScreen extends StatefulWidget {
  final Report report;

  const DiagnosticScreen({super.key, required this.report});

  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  String _status = 'Pendiente';
  final List<Map<String, dynamic>> _materials = [];

  final Map<String, String> _statusOptions = {
    'Pendiente': 'Pendiente',
    'En proceso': 'EnProceso',
    'Completado': 'Completado',
  };

  void _addMaterial() {
    setState(() {
      _materials.add({
        'name': '',
        'supplier': '',
        'quantity': 0,
        'price': 0.0,
      });
    });
  }

  void _removeMaterial(int index) {
    setState(() {
      _materials.removeAt(index);
    });
  }

  void _submitDiagnostic() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final diagnosticID = await ApiService().postDiagnostic(
          reportID: widget.report.reportID,
          description: _description,
          status: _statusOptions[_status]!,
          images: null, // Aquí se envía null para las imágenes
        );

        if (_materials.isNotEmpty) {
          await ApiService().postMaterials(
            diagnosticID: diagnosticID,
            materials: _materials,
          );
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Diagnóstico enviado con éxito')),
        );
        Navigator.pop(context);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnóstico', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primaryColor, // Set AppBar color
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Descripción',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon:
                      const Icon(Icons.description, color: AppColors.primaryColor),
                ),
                onSaved: (value) {
                  _description = value!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una descripción';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: InputDecoration(
                  labelText: 'Estado',
                  labelStyle: TextStyle(color: const Color.fromARGB(255, 0, 0, 0)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  prefixIcon:
                      const Icon(Icons.assignment, color: AppColors.primaryColor),
                ),
                items: _statusOptions.keys
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _status = value!;
                  });
                },
              ),
              const SizedBox(height: 16),
              Text('Materiales',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 8),
              ..._materials.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> material = entry.value;
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Nombre del Material',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.build,
                                color: AppColors.primaryColor),
                          ),
                          onSaved: (value) {
                            material['name'] = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el nombre del material';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Proveedor',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.store,
                                color: AppColors.primaryColor),
                          ),
                          onSaved: (value) {
                            material['supplier'] = value!;
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el proveedor';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Cantidad',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.format_list_numbered,
                                color: AppColors.primaryColor),
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            material['quantity'] = int.parse(value!);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese la cantidad';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Precio',
                            labelStyle: TextStyle(color: Colors.black),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            prefixIcon: const Icon(Icons.attach_money,
                                color: AppColors.primaryColor),
                          ),
                          keyboardType:
                              TextInputType.numberWithOptions(decimal: true),
                          onSaved: (value) {
                            material['price'] = double.parse(value!);
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el precio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: () => _removeMaterial(index),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red),
                          child: Text('Eliminar Material',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                );
              }),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submitDiagnostic,
                style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor),
                child: Text('Enviar Diagnóstico',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
