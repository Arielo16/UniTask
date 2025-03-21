import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart'; // Para kIsWeb
import 'package:permission_handler/permission_handler.dart'; // nuevo import para permisos
import '../models/Reports.dart';
import '../services/api_service.dart';
import '../theme/colors.dart';
import 'home_screen.dart';

class DiagnosticScreen extends StatefulWidget {
  final Report report;

  const DiagnosticScreen({super.key, required this.report});

  @override
  _DiagnosticScreenState createState() => _DiagnosticScreenState();
}

class _DiagnosticScreenState extends State<DiagnosticScreen> {
  final _formKey = GlobalKey<FormState>();
  String _description = '';
  final ImagePicker _picker = ImagePicker();
  List<File> _images = []; // Máximo 3 imágenes

  // Variables para materiales
  List<Map<String, dynamic>> _materialsList = [];
  Map<int, bool> _selectedMaterials = {};
  Map<int, TextEditingController> _quantityControllers = {};

  @override
  void initState() {
    super.initState();
    _fetchMaterials();
  }

  Future<void> _fetchMaterials() async {
    try {
      final materials = await ApiService().fetchMaterials();
      setState(() {
        _materialsList = materials;
        for (var material in materials) {
          int id = material['materialID'];
          _selectedMaterials[id] = false;
          _quantityControllers[id] = TextEditingController();
        }
      });
    } catch (e) {
      // Manejo de error (opcional)
    }
  }

  Future<void> _pickImage() async {
    var status = await Permission.camera.request();
    if (!status.isGranted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Permiso de cámara denegado')),
      );
      return;
    }
    if (_images.length >= 3) return; // Límite de 3 imágenes
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 80, // Comprime la imagen
    );
    if (pickedFile != null) {
      // Verificar que el archivo tenga extensión ".jpg"
      if (!pickedFile.path.toLowerCase().endsWith('.jpg')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Solo se permiten imágenes en formato .jpg')),
        );
        return;
      }
      final file = File(pickedFile.path);
      final int fileSize = await file.length();
      if (fileSize > 5242880) { // 5MB en bytes
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La imagen excede el tamaño máximo de 5MB')),
        );
      } else {
        setState(() {
          _images.add(file);
        });
      }
    }
  }

  void _submitDiagnostic() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Construir la lista de materiales seleccionados con cantidad
      List<Map<String, int>> materialData = [];
      _selectedMaterials.forEach((materialID, selected) {
        if (selected) {
          int quantity = int.tryParse(_quantityControllers[materialID]?.text ?? "0") ?? 0;
          if (quantity > 0) {
            materialData.add({'materialID': materialID, 'quantity': quantity});
          }
        }
      });
      try {
        final diagnosticID = await ApiService().postDiagnostic(
          reportID: widget.report.reportID,
          description: _description,
          status: "En Proceso",
          images: _images.isNotEmpty ? _images.first : null, // se envía solo la primera imagen
          materials: materialData.isNotEmpty ? materialData : null,  // Se pasa la lista de materiales
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Diagnóstico enviado con éxito')),
        );
        Navigator.pushReplacement(
          context, 
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
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
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primaryColor.withOpacity(0.8), Colors.white],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // Campo descripción con estilo elegante
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Descripción',
                          labelStyle: TextStyle(
                              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                          prefixIcon: Icon(Icons.description, color: AppColors.primaryColor),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSaved: (value) { _description = value!; },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor ingrese una descripción';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Fotos (máx 1):',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 10,
                        children: _images.map((file) {
                          return kIsWeb
                              ? FutureBuilder<Uint8List>(
                                  future: file.readAsBytes(),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.memory(
                                          snapshot.data!,
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }
                                    return const SizedBox(width: 100, height: 100);
                                  },
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    file,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                );
                        }).toList(),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor, // cambiado primary por backgroundColor
                          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        label: const Text('Tomar Foto', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      // Sección para mostrar materiales con multi-select y cantidad
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Materiales:',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Column(
                        children: _materialsList.map((material) {
                          int id = material['materialID'];
                          return Row(
                            children: [
                              Checkbox(
                                value: _selectedMaterials[id] ?? false,
                                onChanged: (val) {
                                  setState(() {
                                    _selectedMaterials[id] = val!;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(material['name']),
                              ),
                              if (_selectedMaterials[id] ?? false)
                                Container(
                                  width: 70,
                                  child: TextFormField(
                                    controller: _quantityControllers[id],
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      labelText: "Cantidad",
                                    ),
                                    validator: (value) {
                                      if ((_selectedMaterials[id] ?? false) &&
                                          (value == null || value.isEmpty)) {
                                        return "Requerido";
                                      }
                                      return null;
                                    },
                                  ),
                                )
                            ],
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _submitDiagnostic,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,  // cambiado primary por backgroundColor
                          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text('Enviar Diagnóstico',
                            style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
